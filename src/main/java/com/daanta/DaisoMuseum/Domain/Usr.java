package com.daanta.DaisoMuseum.Domain;

import lombok.Data;

/**
 * Usr
 */
@Data
public class Usr {

    int usr_idx;
    int grd_idx;
    String usr_mail;
    String usr_pw;
    String usr_nm;
    String usr_reg_dt;
    String usr_chg_dt;
    String usr_del_dt;

}
