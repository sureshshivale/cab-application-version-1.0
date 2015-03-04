package cab.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cab.dao.entity.UserProfile;

import cab.bo.CabService;
import cab.dto.CabDto;
import cab.dto.CabRouteDto;
import cab.dto.CabTableBean;
import cab.dto.DashBoardBean;
import cab.dto.TimeslotDto;
import cab.dto.UserProfileDto;

@Controller
public class HomeController {
	private CabService cabservice;

	@RequestMapping("login")
	public ModelAndView loginCheck(
			@RequestParam(value = "userId", required = false) String userid,
			HttpSession session) {
		cabservice = loadContext();
		boolean isValidLogin = false;
		isValidLogin = cabservice.isValidLogin(userid, session);
		if (isValidLogin) {
			session.setAttribute("userid", userid);
			return new ModelAndView("Home");
		} else {
			return new ModelAndView("redirect:aaa.htm");
		}
	}

	@RequestMapping("refreshdash")
	public @ResponseBody
	List<DashBoardBean> refreshdash(HttpSession session) {
		cabservice = loadContext();
		List<DashBoardBean> allresult = new ArrayList<DashBoardBean>();
		List<CabDto> allcab = cabservice.getAllCabs();
		for (CabDto cabdto : allcab) {
			List<DashBoardBean> details = cabservice.getCabDetails(
					cabdto.getCabNumber(), cabdto.getCabCapacity());
			for (DashBoardBean db : details) {
				allresult.add(db);
			}
		}
		session.setAttribute("FirstCabInfo", allresult.get(0));
		return allresult;
	}

	@RequestMapping("refreshCabTableData")
	public @ResponseBody
	CabTableBean refreshCabTableData(HttpSession session) {
		cabservice = loadContext();
		DashBoardBean dbb = (DashBoardBean) session
				.getAttribute("FirstCabInfo");

		CabTableBean firstcabinfo = cabservice.getFirstCabTabData(
				dbb.getCabNum(), dbb.getCabTime(), dbb.getCabRoute());

		return firstcabinfo;
	}

	@RequestMapping("refreshUserTableData")
	public @ResponseBody
	List<UserProfileDto> refreshUserTableData(HttpSession session) {
		cabservice = loadContext();
		DashBoardBean dbb = (DashBoardBean) session
				.getAttribute("FirstCabInfo");

		List<UserProfileDto> users = cabservice.getFirstUserTabData(
				dbb.getCabNum(), dbb.getCabTime(), dbb.getCabRoute());
		if (users != null)
			return users;
		else
			return null;
	}

	@RequestMapping("getCabClickInfoUser")
	public @ResponseBody
	List<UserProfileDto> getCabClickInfoUser(
			@RequestParam(value = "cabNum") String cabNum,
			@RequestParam(value = "cabTime") String cabTime,
			@RequestParam(value = "cabRoute") String cabRoute) {
		cabservice = loadContext();

		List<UserProfileDto> users = cabservice.getFirstUserTabData(cabNum,
				cabTime, cabRoute);
		if (users != null)
			return users;
		else
			return null;
	}

	@RequestMapping("getCabClickInfoCab")
	public @ResponseBody
	CabTableBean getCabClickInfoCab(
			@RequestParam(value = "cabNum") String cabNum,
			@RequestParam(value = "cabTime") String cabTime,
			@RequestParam(value = "cabRoute") String cabRoute) {
		cabservice = loadContext();
		CabTableBean cabinfo = cabservice.getFirstCabTabData(cabNum, cabTime,
				cabRoute);

		return cabinfo;
	}

	@RequestMapping("logout")
	public ModelAndView logout(HttpSession session) {
		session.removeAttribute("user");
		session.invalidate();
		return new ModelAndView("Home");
	}

	@RequestMapping("aaa.htm")
	public ModelAndView user(Model model) {
		model.addAttribute("userdto", new UserProfileDto());
		return new ModelAndView("UserSignUp");
	}

	@RequestMapping(value = "adduser")
	public ModelAndView adduser(
			@ModelAttribute("userdto") UserProfileDto userdto,
			HttpSession session, ModelMap model) {

		cabservice = loadContext();
		boolean doesUserExist = false;
		doesUserExist=cabservice.doesUserExist(userdto);
		if(!doesUserExist){
			boolean isInsert = false;		
			isInsert = cabservice.isInsert(userdto);
			if (isInsert) {
				session.setAttribute("userid", userdto.getUserId());
				session.setAttribute("username", userdto.getUserName());
				return new ModelAndView("Home");
			} else {
				return new ModelAndView("UserSignUp");
			}
		}else{
			session.setAttribute("message", "user already registerd");
			return new ModelAndView("redirect:aaa.htm");
		}
		
	}

	@RequestMapping("setting.htm")
	public ModelAndView setting(Model model) {
		model.addAttribute("cabdto", new CabDto());
		cabservice = loadContext();
		List<CabDto> cab = cabservice.getAllCabs();
		List<String> cabnumlist = new ArrayList<String>();
		for (CabDto c : cab)
			cabnumlist.add(c.getCabNumber());
		ModelAndView modelvw = new ModelAndView("Settings");
		modelvw.addObject("cabnumlist", cabnumlist);
		return modelvw;
	}	
		

	@RequestMapping(value = "addCab")
	public ModelAndView adduser(@ModelAttribute("cabdto") CabDto cabdto,
			HttpSession session) {

		cabservice = loadContext();
		boolean isCabInsert = false;

		isCabInsert = cabservice.isCabInsert(cabdto);

		if (isCabInsert) {
			System.out.println("Inserted");
			session.setAttribute("message", "Cab Inserted");
			return new ModelAndView("redirect:setting.htm");
		} else {
			System.out.println("Not Inserted");
			session.setAttribute("message", "Cab not Inserted");
			return new ModelAndView("redirect:setting.htm");
		}
	}

	@RequestMapping("managecab")
	public ModelAndView manageUser(@ModelAttribute("cabdto") CabDto cabdto,
			HttpSession session) {

		cabservice = loadContext();
		boolean isCabUpdate = false;

		cabdto.setCabNumber(cabdto.getCabNumber().substring(1));
		cabdto.setCabDriverName(cabdto.getCabDriverName().substring(1));
		cabdto.setCabDriverPhone(cabdto.getCabDriverPhone().substring(1));
		System.out.println("cabcap::" + cabdto.getCabPoc());
		cabdto.setCabCapacity(Integer.parseInt(cabdto.getCabCapacitystr()));
		cabdto.setCabPoc(cabdto.getCabPoc().substring(1));
		isCabUpdate = cabservice.isCabUpdate(cabdto);

		if (isCabUpdate) {
			System.out.println("Inserted");
			session.setAttribute("message", "Cab Updated");
			return new ModelAndView("redirect:setting.htm");
		} else {
			System.out.println("Not Inserted");
			session.setAttribute("message", "Cab not Updated");
			return new ModelAndView("redirect:setting.htm");
		}

	}

	@RequestMapping("updatecontact")
	public ModelAndView manageEmp(HttpSession session,
			@RequestParam("contactno") String contactno,@RequestParam("emailid") String emailid) {
		cabservice = loadContext();
		boolean isContactUpdate = false;
		boolean isEmailUpdate = false;
		int alphcount=0;
		int contactValidate=0;
		int emailValidate=0;
		String userid = "";
		String EMAIL_REGEX = "^[\\w-_\\.+]*[\\w-_\\.]\\@([\\w]+\\.)+[\\w]+[\\w]$";	
		/*Boolean emailcheck=emailid.matches(EMAIL_REGEX);*/

		if (session.getAttribute("userid") != null)
		{
			userid = (String) session.getAttribute("userid");
		}
		
		for(int i=0;i<contactno.length();i++)
		{
			if(Character.isAlphabetic(contactno.charAt(i)))
			{
				alphcount++;
			}
		}
		if(emailid.isEmpty()&&contactno.isEmpty()){
			session.setAttribute("message", "please enter an entity to update");
			return new ModelAndView("redirect:setting.htm");
		}
		else if(emailid.isEmpty()&&!(contactno.isEmpty()))
		{
			if(contactno.length()!=10||alphcount!=0)
			{
				session.setAttribute("message", "please enter a valid contact number");
				return new ModelAndView("redirect:setting.htm");
			}else{
				isContactUpdate=cabservice.isContactUpdate(userid, contactno);
				if(isContactUpdate)
				{
					session.setAttribute("message", "User Contacts Updated");
					return new ModelAndView("redirect:setting.htm");
				}else
				{
					session.setAttribute("message", "User Contacts not Updated");
					return new ModelAndView("redirect:setting.htm");
				}
				}
		}else if(!(emailid.isEmpty())&&contactno.isEmpty())
		{
			Boolean emailcheck=emailid.matches(EMAIL_REGEX);
			if(emailcheck)
			{
				isEmailUpdate=cabservice.isEmailUpdate(userid, emailid);
				if(isEmailUpdate)
				{
					session.setAttribute("message", "User Email Updated");
					return new ModelAndView("redirect:setting.htm");
				}else
				{
					session.setAttribute("message", "User Email not Updated");
					return new ModelAndView("redirect:setting.htm");
				}
			}else{
				session.setAttribute("message", "please enter a valid email id");
				return new ModelAndView("redirect:setting.htm");
			}
		}
		else{
			session.setAttribute("message", "profile not updated.Please try again!!!");
			return new ModelAndView("redirect:setting.htm");
		}			
	}		
	@RequestMapping("manageadmin")
	public ModelAndView manageAdmin(HttpSession session,
			@RequestParam("adminid") String adminid) {
		cabservice = loadContext();
		boolean isAdminUpdate = false;
		int alphcount=0;
		String userid = "";
		if (session.getAttribute("userid") != null) {
			userid = (String) session.getAttribute("userid");

		}
		for(int i=0;i<adminid.length();i++)
		{
			if(Character.isAlphabetic(adminid.charAt(i)))
			{
				alphcount++;
			}
		}
		if(adminid.length()!=6||alphcount!=0)
		{
			session.setAttribute("message", "Id should be 6 digit in length");
			return new ModelAndView("redirect:setting.htm");
		}else{
			isAdminUpdate = cabservice.isAdminUpdate(userid, adminid);
			if (isAdminUpdate) {
				System.out.println("Inserted");			
				return new ModelAndView("redirect:logout");
			} else {
				System.out.println("Not Inserted");
				session.setAttribute("message", "Admin Id not Updated");
				return new ModelAndView("redirect:setting.htm");
			}
		}
			
		}

	@RequestMapping("cabdetails")
	public @ResponseBody
	CabDto getCabDetailsWithId(@RequestParam("cabnum") String cabnum) {
		cabservice = loadContext();
		CabDto cabinfo = cabservice.getCabDetailsWithId(cabnum);
		System.out.println("driv::" + cabinfo.getCabCapacity());
		return cabinfo;
	}

	@RequestMapping("booking.htm")
	public ModelAndView booking(Model model) {

		model.addAttribute("cabroutedto", new CabRouteDto());
		cabservice = loadContext();

		List<CabRouteDto> allCabDir = cabservice.getAllCabDirection();

		Set<String> dir = new HashSet<String>();
		for (CabRouteDto cabrtdto : allCabDir) {

			dir.add(cabrtdto.getCabDirection());
		}
		List<TimeslotDto> allCabTime = cabservice.getAllCabTime();

		Set<String> time = new HashSet<String>();
		for (TimeslotDto cabtimedto : allCabTime) {

			time.add(cabtimedto.getTimeSlot());
		}

		ModelAndView modelvw = new ModelAndView("Booking");
		modelvw.addObject("directionset", dir);
		modelvw.addObject("timeset", time);

		return modelvw;
	}

	@RequestMapping("getroute")
	public @ResponseBody
	List<String> getCabRoute(@RequestParam("direction") String direction) {
		List<String> routelist = new ArrayList<String>();
		cabservice = loadContext();
		routelist = cabservice.getCabRoute(direction);
		System.out.println("routelist::" + routelist);
		return routelist;
	}

	@RequestMapping("bookcab")
	public ModelAndView bookCab(@RequestParam("route") String route,
			@RequestParam("time") String time, HttpSession session) {
		boolean isBookingDone = false;
		boolean isBookingAvailable = false;
		cabservice = loadContext();
		String userid = "";
		if (session.getAttribute("userid") != null)
			userid = (String) session.getAttribute("userid");
		isBookingAvailable = cabservice.findUserBooking(userid);
		if (isBookingAvailable) {
			isBookingDone = cabservice.bookCab(route, time, userid);
			if (isBookingDone)
				return new ModelAndView("Home");
			else {
				session.setAttribute("str", "Your Booking Confirmed");
				return new ModelAndView("redirect:booking.htm");

			}
		} else {
			session.setAttribute("str",
					"You are not permitted to book more than one cab");
			return new ModelAndView("redirect:booking.htm");
		}
	}

	public static CabService loadContext() {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"beans.xml");
		CabService cab = (CabService) context.getBean("cabservice");
		return cab;

	}

}
