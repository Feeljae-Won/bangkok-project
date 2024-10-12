package com.bangkok.member.restcontroller;

import com.bangkok.member.service.MemberService;
import com.bangkok.member.vo.GoogleMemberVO;
import com.bangkok.member.vo.MemberVO;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
public class GoogleLoginController {

    private static final String CLIENT_ID = "862325386717-j1pfdincqeu0qo2991glaj4u72bm96vr.apps.googleusercontent.com";

    private final HttpTransport httpTransport = new NetHttpTransport();
    private final JsonFactory jsonFactory = GsonFactory.getDefaultInstance();

    @Autowired
    @Qualifier("memberServiceImpl")
    private MemberService service;

    @PostMapping("/googleLogin.do")
    public Map<String, Object> handleGoogleLogin(@RequestBody Map<String, String> requestBody, HttpSession session) throws GeneralSecurityException {
        String idTokenString = requestBody.get("token");
        String email = requestBody.get("email");

        Map<String, Object> response = new HashMap<>();

        try {
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(httpTransport, jsonFactory)
                    .setAudience(Arrays.asList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();
                MemberVO vo = service.findByEmail(email != null ? email : payload.getEmail());

                if (vo == null) {
                    GoogleMemberVO googleMember = new GoogleMemberVO();
                    googleMember.setEmail(email != null ? email : payload.getEmail());
                    googleMember.setName((String) payload.get("name"));
                    googleMember.setPhoto((String) payload.get("picture")); // 프로필 사진 URL도 포함
                    service.saveGoogleMember(googleMember);
                    vo = service.findByEmail(googleMember.getEmail()); // 새로 저장한 회원 정보 가져오기
                }

                session.setAttribute("user", vo); // "vo" 대신 "user"로 세션에 저장

                response.put("status", "success");
            } else {
                response.put("status", "error");
                response.put("message", "유효하지 않은 ID 토큰입니다.");
            }

        } catch (IOException e) {
            response.put("status", "error");
            response.put("message", "구글 로그인에 실패했습니다.");
        }

        return response;
    }

    // 로그아웃 처리
    @PostMapping("/logout.do")
    public Map<String, Object> logout(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // 세션 무효화
        session.invalidate();
        response.put("status", "success");
        response.put("msg", "로그아웃이 성공적으로 처리되었습니다.");

        return response;
    }

}