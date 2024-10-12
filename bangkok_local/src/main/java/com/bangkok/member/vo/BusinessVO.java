package com.bangkok.member.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BusinessVO {

    private int business_no;
    private String email;
    private String office_adr;
    private String office_num;
    private String detail_adr;
    private String office_name;
    private int post_code;
    
}
