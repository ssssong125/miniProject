package com.hello.uims.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import com.hello.uims.controller.Controller;
import com.hello.uims.model.DTO.EnrollmentDTO;
import com.hello.uims.model.DTO.GradeDTO;
import com.hello.uims.model.DTO.LectureJugDTO;
import com.hello.uims.model.DTO.ProfessorDTO;
import com.hello.uims.model.DTO.StudentDTO;

public class UimsMenu {

	private static Scanner sc = new Scanner(System.in);
	private Controller con = new Controller();

	public void initialMenu() {

		do {
			int no;

			System.out.println("============================ 학사 통합 관리 시스템 ===========================");
			System.out.println("1. 로그인");
			System.out.println("2. 회원가입");
			System.out.println("9. 프로그램 종료");
			System.out.println("=========================================================================");
			System.out.print("메뉴 선택 : ");

			no = sc.nextInt();
			sc.nextLine();

			switch (no) {
			case 1:
				login();
				break;

			case 2:
				signUp();
				break;

			case 9:
				System.out.print("프로그램을 종료하시겠습니까? (y/n) : ");
				if ('y' == sc.nextLine().toLowerCase().charAt(0)) {
					sc.close();
					return;
				}

			default:
				System.out.println("잘못 입력하셨습니다.");
				break;
			}

		} while (true);

	}

	public void login() {

		// 학생용 교수용 나누나?? 나눌거면 메인메뉴도 교수용거 하나 만들어야겠다
		// 이거는 제대로 됬나 확인하려고 일단 임시로 이렇게 해둔거고 지수형이 추가해줘용
		System.out.println("=============로그인============");
		System.out.println("학생입니까? 1번");
		System.out.println("교수입니까? 2번");
		System.out.println("=========================");
		System.out.print("메뉴 선택 : ");

		int no = sc.nextInt();
		sc.nextLine();

		switch (no) {
		case 1:
			while (true) {
				StudentDTO student = con.selectLoginStudent(inputStuId());

				if (student != null) {
					System.out.println("비밀번호를 입력하세요(대소문자 구분합니다)");

					if (student.getStudentPwd().equals(sc.nextLine())) {
						stuMainMenu();
						break;
					} else {
						System.out.println("비밀번호가 틀렸습니다.");
					}
				}
			}
			break;

		case 2:
			while (true) {
				ProfessorDTO professor = con.selectLoginProfessor(inputProId());

				if (professor != null) {
					System.out.println("비밀번호를 입력하세요(대소문자 구분합니다)");

					if (professor.getProfPwd().equals(sc.nextLine())) {
						profMainMenu();
						break;
					} else {
						System.out.println("비밀번호가 틀렸습니다.");
					}
				}
			}
			break;
		}

	}

	private HashMap<String, String> inputProId() {

		HashMap<String, String> loginMap = new HashMap<>();
		System.out.println("아이디를 입력하세요");
		loginMap.put("professorId", sc.nextLine());

		return loginMap;
	}

	private HashMap<String, String> inputStuId() {

		HashMap<String, String> loginMap = new HashMap<>();
		System.out.println("아이디를 입력하세요");
		loginMap.put("studentId", sc.nextLine());

		return loginMap;

	}

	private void signUp() {
		// 지수형 회원가입 파트
		System.out.println("=============회원가입============");
		System.out.println("학생입니까? 1번");
		System.out.println("교수입니까? 2번");
		System.out.println("=========================");
		System.out.print("메뉴 선택 : ");

		int no = sc.nextInt();
		sc.nextLine();

		switch (no) {
		case 1:

			HashMap<String, String> infoMap = new HashMap<>();
			con.insertStudent(infoMap);

			System.out.println("===============================회원가입===================================");
			System.out.println("아이디를 설정하세요");
			infoMap.put("studentId", sc.nextLine());
			System.out.println("비밀번호를 설정하세요(특수문자 제외)");
			infoMap.put("studentPwd", sc.nextLine());
			System.out.println("이름을 입력하세요");
			infoMap.put("studentName", sc.nextLine());
			System.out.println("휴대전화번호를 입력하세요");
			infoMap.put("studentTelNo", sc.nextLine());

			break;

//		case 2:
//			while (true) {
//
//				HashMap<String, String> infoMap = new HashMap<>();
//			
//				System.out.println("===============================회원가입===================================");
//				System.out.println("아이디를 설정하세요");
//				infoMap.put("professorId", sc.nextLine());
//				System.out.println("비밀번호를 설정하세요(특수문자 제외)");
//				infoMap.put("professorPwd", sc.nextLine());
//				System.out.println("이름을 입력하세요");
//				infoMap.put("professorName", sc.nextLine());
//				System.out.println("휴대전화번호를 입력하세요");
//				infoMap.put("professorTelNo", sc.nextLine());
//				
//				con.insertProfessor(infoMap);
//				break;
//			}
		}

	}

	public void stuMainMenu() { // 학생용 메뉴 화면

		do {
			int no;

			System.out.println("=========================== 학사 통합 관리 시스템 ===========================");
			System.out.println("1. 마이페이지");
			System.out.println("2. 수강신청 메뉴");
			System.out.println("3. 학점조회");
			System.out.println("4. 강의평가");
			System.out.println("5. 로그아웃");
			System.out.println("=========================================================================");
			System.out.print("메뉴 선택 : ");

			no = sc.nextInt();
			sc.nextLine();

			switch (no) {
			case 1:
//				con.myPage();
				break;

			case 2:
				enrollMenu();
				break;

			case 3:
				con.selectGradeCheck(inputStudentNo());
				break;

			case 4:
				lectureJug(inputStudentNo());
				break;

			case 5:
				return;

			default:
				System.out.println("잘못 입력하셨습니다.");
				break;
			}

		} while (true);

	}

	public void profMainMenu() { // 교수용 메뉴 화면
		// 이거도 일단 임시로 복붙한거라 다들 자기 파트 부분 수정해 죠 해 줘
		do {
			int no;

			System.out.println("=========================== 학사 통합 관리 시스템 ===========================");
			System.out.println("1. 지수형");
			System.out.println("2. 학점관리");
			System.out.println("3. 강의평가조회");
			System.out.println("9. 로그아웃");
			System.out.println("=========================================================================");
			System.out.print("메뉴 선택 : ");

			no = sc.nextInt();
			sc.nextLine();

			switch (no) {
			case 1:
//				con.myPage();
				break;

			case 2:
				manageGrade(inputProfNo());
				break;

			case 3:
				viewJudgement(inputProfNo());
				break;

			case 9:
				return;

			default:
				System.out.println("잘못 입력하셨습니다.");
				break;
			}

		} while (true);

	}

	public void enrollMenu() {

		do {
			int no;

			System.out.println("================================ 수강신청 =================================");
			System.out.println("1. 강의목록 조회");
			System.out.println("2. 수강신청");
			System.out.println("3. 수강신청 내역");
			System.out.println("4. 수강신청 취소");
			System.out.println("9. 돌아가기");
			System.out.println("=========================================================================");
			System.out.print("메뉴 선택 : ");

			no = sc.nextInt();
			sc.nextLine();

			switch (no) {
			case 1:
				con.selectAllLecture();
				break;

			case 2:
				con.enroll(inputEnroll());
				break;

			case 3:
				con.selectEnroll(inputStudentNo());
				break;

			case 4:
				con.deleteEnroll(inputEnroll());
				break;

			case 9:
				return;

			default:
				System.out.println("잘못 입력하셨습니다.");
				break;
			}

		} while (true);

	}

	// 학번 강의코드 입력
	public Map<String, String> inputEnroll() {

		Map<String, String> parameter = new HashMap<>();

		System.out.print("학번을 입력해주세요 : ");
		parameter.put("studentNo", sc.nextLine());

		System.out.print("강의코드를 입력해주세요 : ");
		parameter.put("lectureNo", sc.nextLine());

		return parameter;

	}

	private void manageGrade(Map<String, String> parameter) { // 교수 학점 관리 메뉴

		int no;

		do {
			con.selectByProfNo(parameter);
			System.out.println("================================ 학점 관리 ================================");
			System.out.println("1. 학점 부여");
			System.out.println("2. 학점 수정");
			System.out.println("3. 학점 삭제");
			System.out.println("4. 돌아가기");
			System.out.println("=========================================================================");
			System.out.print("메뉴 선택 : ");

			no = sc.nextInt();
			sc.nextLine();

			switch (no) {
			case 1:
				parameter.put("lectureNo", inputLectureNo().get("lectureNo"));
				insertScores(parameter);
				break;
			case 2:
				parameter.put("lectureNo", inputLectureNo().get("lectureNo"));
				updateGrade(parameter);
				break;
			case 3:
				parameter.put("lectureNo", inputLectureNo().get("lectureNo"));
				deleteGrade(parameter);
				break;
			case 9:
				return;
			default:
				System.out.println("잘못 입력하셨습니다.");
				break;
			}
		} while (true);
	}

	private void insertScores(Map<String, String> parameter) {

		String attScore;
		String assScore;
		String midScore;
		String finScore;
		ArrayList<EnrollmentDTO> enroll = con.selectStudentList(parameter);

		int index1 = 0;
		int index2 = 1;
		int size = enroll.size();
		while (index1 < size) {
			System.out.println("================================ 수강생 목록 ================================");
			while (index1 < size) {
				System.out.println(enroll.get(index1).getStudentNo());
				index1++;
			}
			System.out.println("=========================================================================");
			index1 = index2;
			System.out.print("학점을 입력할 학생의 ");
			parameter.put("studentNo", inputStudentNo().get("studentNo"));
			System.out.println("=========================================================================");
			while (true) {
				System.out.print("출석 점수를 입력하세요. (0 ~ 10) : ");
				attScore = sc.nextLine();
				if (Integer.parseInt(attScore) < 0 || Integer.parseInt(attScore) > 10) {
					System.out.println("잘못된 값을 입력했습니다. 0 ~ 10의 점수를 입력해주세요.");
				} else {
					break;
				}
			}
			parameter.put("attScore", attScore);
			while (true) {
				System.out.print("과제 점수를 입력하세요. (0 ~ 30) : ");
				assScore = sc.nextLine();
				if (Integer.parseInt(assScore) < 0 || Integer.parseInt(assScore) > 30) {
					System.out.println("잘못된 값을 입력했습니다. 0 ~ 30의 점수를 입력해주세요.");
				} else {
					break;
				}
			}
			parameter.put("assScore", assScore);
			while (true) {
				System.out.print("중간고사 점수를 입력하세요. (0 ~ 30) : ");
				midScore = sc.nextLine();
				if (Integer.parseInt(midScore) < 0 || Integer.parseInt(midScore) > 30) {
					System.out.println("잘못된 값을 입력했습니다. 0 ~ 30의 점수를 입력해주세요.");
				} else {
					break;
				}
			}
			parameter.put("midScore", midScore);
			while (true) {
				System.out.print("기말고사 점수를 입력하세요. (0 ~ 30) : ");
				finScore = sc.nextLine();
				if (Integer.parseInt(finScore) < 0 || Integer.parseInt(finScore) > 30) {
					System.out.println("잘못된 값을 입력했습니다. 0 ~ 30의 점수를 입력해주세요.");
				} else {
					break;
				}
			}
			parameter.put("finScore", finScore);
			con.insertScores(parameter);

			System.out.println("=========================================================================");
			System.out.println("학점을 추가로 입력하시겠습니까? (y/n)");
			if ('y' == sc.nextLine().toLowerCase().charAt(0)) {
				index2++;
				if (index2 == size) {
					con.updateFinGrade(parameter);
					System.out.println("모든 학생의 학점을 부여했습니다. 학점 관리 메뉴로 돌아갑니다.");
					break;
				}
				continue;
			} else {
				con.updateFinGrade(parameter);
				System.out.println("학점 관리 메뉴로 돌아갑니다.");
				break;
			}
		}

	}

	private void updateGrade(Map<String, String> parameter) {

		String attScore;
		String assScore;
		String midScore;
		String finScore;

		while (true) {
			ArrayList<GradeDTO> list = con.selectGrade(parameter);

			if (list != null && !list.isEmpty()) {
				System.out.println("=========================================================================");
				System.out.print("수정할 학생의 ");
				parameter.put("studentNo", inputStudentNo().get("studentNo"));
			} else {
				break;
			}
			System.out.println("================================ 학점 수정 ================================");
			while (true) {
				System.out.print("출석 점수를 입력하세요. (0 ~ 10) : ");
				attScore = sc.nextLine();
				if (Integer.parseInt(attScore) < 0 || Integer.parseInt(attScore) > 10) {
					System.out.println("잘못된 값을 입력했습니다. 0 ~ 10의 점수를 입력해주세요.");
				} else {
					break;
				}
			}
			parameter.put("attScore", attScore);
			while (true) {
				System.out.print("과제 점수를 입력하세요. (0 ~ 30) : ");
				assScore = sc.nextLine();
				if (Integer.parseInt(assScore) < 0 || Integer.parseInt(assScore) > 30) {
					System.out.println("잘못된 값을 입력했습니다. 0 ~ 30의 점수를 입력해주세요.");
				} else {
					break;
				}
			}
			parameter.put("assScore", assScore);
			while (true) {
				System.out.print("중간고사 점수를 입력하세요. (0 ~ 30) : ");
				midScore = sc.nextLine();
				if (Integer.parseInt(midScore) < 0 || Integer.parseInt(midScore) > 30) {
					System.out.println("잘못된 값을 입력했습니다. 0 ~ 30의 점수를 입력해주세요.");
				} else {
					break;
				}
			}
			parameter.put("midScore", midScore);
			while (true) {
				System.out.print("기말고사 점수를 입력하세요. (0 ~ 30) : ");
				finScore = sc.nextLine();
				if (Integer.parseInt(finScore) < 0 || Integer.parseInt(finScore) > 30) {
					System.out.println("잘못된 값을 입력했습니다. 0 ~ 30의 점수를 입력해주세요.");
				} else {
					break;
				}
			}
			parameter.put("finScore", finScore);

			con.updateGrade(parameter);

			System.out.println("추가로 수정하시겠습니까? (y/n)");
			if ('y' == sc.nextLine().toLowerCase().charAt(0)) {
				continue;
			} else {
				con.updateFinGrade(parameter);
				System.out.println("학점 관리 메뉴로 돌아갑니다.");
				break;
			}
		}
	}

	private void deleteGrade(Map<String, String> parameter) {

		while (true) {
			ArrayList<GradeDTO> list = con.selectGrade(parameter);

			if (list != null && !list.isEmpty()) {
				System.out.println("=========================================================================");
				System.out.print("학점을 삭제할 학생의 ");
				parameter.put("studentNo", inputStudentNo().get("studentNo"));
			} else {
				break;
			}

			con.deleteGrade(parameter);

			System.out.println("추가로 삭제하시겠습니까? (y/n)");
			if ('y' == sc.nextLine().toLowerCase().charAt(0)) {
				continue;
			} else {
				System.out.println("학점 관리 메뉴로 돌아갑니다.");
				con.updateFinGrade(parameter);
				break;
			}
		}
	}

	private Map<String, String> inputStudentNo() {

		System.out.print("학번을 입력하세요. : ");
		String studentNo = sc.nextLine();

		Map<String, String> parameter = new HashMap<>();
		parameter.put("studentNo", studentNo);
		
		return parameter;

	}

	private Map<String, String> inputProfNo() {
		
		System.out.print("교수 번호를 입력하세요. : ");
		String profNo = sc.nextLine();

		Map<String, String> parameter = new HashMap<>();
		parameter.put("profNo", profNo);

		return parameter;

	}

	private Map<String, String> inputLectureNo() {

		System.out.print("강의 번호를 입력하세요. : ");
		String lectureNo = sc.nextLine();

		Map<String, String> parameter = new HashMap<>();
		parameter.put("lectureNo", lectureNo);

		return parameter;

	}

	private Map<String, String> inputJudgemnetNo() {

		System.out.print("강의 평가 번호를 입력하세요. : ");
		String judgementNo = sc.nextLine();

		Map<String, String> parameter = new HashMap<>();
		parameter.put("judgementNo", judgementNo);

		return parameter;
	}

	private void lectureJug(Map<String, String> parameter) {

		do {

			int no;
			con.selectByStudentNo(parameter);

			System.out.println("================================ 강의평가 =================================");
			System.out.println("1. 교수 강의 평가");
			System.out.println("2. 평가 수정");
			System.out.println("3. 평가 삭제");
			System.out.println("4. 평가조회");
			System.out.println("9. 돌아가기");
			System.out.println("=========================================================================");

			System.out.println("메뉴 선택 : ");

			no = sc.nextInt();
			sc.nextLine();

			switch (no) {

			case 1:
				updateJudge(parameter);
				break;
			case 2:
				modifyJudge(parameter);
				break;
			case 3:
				deleteJudge(parameter);
				break;
			case 4:
				showJudge(parameter);
				break;
			case 9:

				stuMainMenu();
				break;
        
			default:
				System.out.println("잘못 입력하셨습니다.");
				break;
			}

		} while (true);

	}

	private void updateJudge(Map<String, String> parameter) {
		System.out.println("=========================================================================");
		System.out.print("강의 평가할 교수의 ");
		parameter.put("profNo", inputProfNo().get("profNo"));
		System.out.println("=========================================================================");
		System.out.print("강의 평가할 ");
		parameter.put("lectureNo", inputLectureNo().get("lectureNo"));
		double avg = 0.0;
		
		System.out.println("질문에 알맞게 점수를 입력해주세요");
		System.out.println("강의 목표와 강의내용이 강좌명과 부합하는가? (1 ~ 5점으로 입력해주세요)");
		int score1 = sc.nextInt();
		System.out.println("강의내용은 해당영역의 이론과 지식을 적절히 담고 있는가? (1 ~ 5점으로 입력해주세요)");
		int score2 = sc.nextInt();
		System.out.println("담당교수는 학생들의 이해도를 높이기 위하여 최선을 다하였는가? (1 ~ 5점으로 입력해주세요)");
		int score3 = sc.nextInt();
		System.out.println("담당교수는 열성적이고 성실하게 강의에 임하였는가? (1 ~ 5점으로 입력해주세요)");
		int score4 = sc.nextInt();
		System.out.println("학업평가는 강의내용이 적절히 반영되어 과목의 이해정도를 잘 평가하였 는가? (1 ~ 5점으로 입력해주세요)");
		int score5 = sc.nextInt();
		sc.nextLine();

		avg = (double) (score1 + score2 + score3 + score4 + score5) / 5;

		String avgs = Double.toString(avg);

		parameter.put("stuJugScore", avgs);

		System.out.println("교수님에게 할 말 한 문장으로 남겨주세요.");
		parameter.put("stuOneJug", sc.nextLine());

		System.out.println("평가 점수의 평균은 " + avg + "입니다.");
		con.inputJudgement(parameter);

	}

	private void modifyJudge(Map<String, String> parameter) {
		double avg = 0.0;
		while (true) {
			ArrayList<LectureJugDTO> list = con.selectJudgement(parameter);
			if (list != null && !list.isEmpty()) {
				System.out.println("=========================================================================");
				System.out.print("강의 평가 수정할 ");
				parameter.put("judgementNo", inputJudgemnetNo().get("judgementNo"));
			} else {
				System.out.println("옳지 않은 강의 평가 번호 입니다 다시 입력해주세요.");

			}
			break;
		}

		System.out.println("질문에 알맞게 점수를 입력해주세요");
		System.out.println("강의 목표와 강의내용이 강좌명과 부합하는가? (1 ~ 5점으로 입력해주세요)");
		int score1 = sc.nextInt();
		System.out.println("강의내용은 해당영역의 이론과 지식을 적절히 담고 있는가? (1 ~ 5점으로 입력해주세요)");
		int score2 = sc.nextInt();
		System.out.println("담당교수는 학생들의 이해도를 높이기 위하여 최선을 다하였는가? (1 ~ 5점으로 입력해주세요)");
		int score3 = sc.nextInt();
		System.out.println("담당교수는 열성적이고 성실하게 강의에 임하였는가? (1 ~ 5점으로 입력해주세요)");
		int score4 = sc.nextInt();
		System.out.println("학업평가는 강의내용이 적절히 반영되어 과목의 이해정도를 잘 평가하였 는가? (1 ~ 5점으로 입력해주세요)");
		int score5 = sc.nextInt();
		sc.nextLine();

		avg = (double) (score1 + score2 + score3 + score4 + score5) / 5;

		String avgs = Double.toString(avg);

		parameter.put("stuJugScore", avgs);

		System.out.println("교수님에게 할 말 한 문장으로 다시 남겨주세요.");
		parameter.put("stuOneJug", sc.nextLine());

		System.out.println("평가 점수의 평균은 " + avg + "입니다.");
		con.modifyJudgement(parameter);

	}

	private void deleteJudge(Map<String, String> parameter) {

		while (true) {
			ArrayList<LectureJugDTO> list = con.selectJudgement(parameter);
			if (list != null && !list.isEmpty()) {
				System.out.println("=========================================================================");
				System.out.print("강의 평가 삭제할 ");
				parameter.put("judgementNo", inputJudgemnetNo().get("judgementNo"));
			} else {
				break;
			}

			con.deleteJudgement(parameter);

			break;

		}
	}

	private void showJudge(Map<String, String> parameter) {
		con.selectJudgement(parameter);

	}

	private void viewJudgement(Map<String, String> inputProfNo) {

		while (true) {
			con.selectByProfNo(inputProfNo);
			System.out.println("=========================================================================");
			System.out.println("강의 평가 조회 하고 싶은 ");
			inputProfNo.put("lectureNo", inputLectureNo().get("lectureNo"));

			con.selectJudmentProf(inputProfNo);

			break;
		}

	}

}
