package com.daanta.DaisoMuseum.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * DaisoMuseumController
 */
@Controller
@Slf4j
public class DaisoMuseumController {

    @GetMapping("/index")
    public String index() {
        log.debug("메인 화면 접속");
        return "/WEB-INF/views/index.html";
    }
    
}