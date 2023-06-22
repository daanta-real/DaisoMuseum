package com.daanta.DaisoMuseum.Controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * DaisoMuseumController
 */
@Slf4j
@Controller
@RequestMapping("/")
public class DaisoMuseumController {

    @GetMapping({"", "index"})
    public String index() {
        log.debug("메인 화면 접속");
        return "views/index"; ///WEB-INF/views/
    }
    
}
