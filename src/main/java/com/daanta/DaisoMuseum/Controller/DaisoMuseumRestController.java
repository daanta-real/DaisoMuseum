package com.daanta.DaisoMuseum.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

/**
 * DaisoMuseumController
 */
@RestController
@Slf4j
public class DaisoMuseumRestController {

    @GetMapping("/index2")
    public String index2() {
        log.debug("/index2");
        return "전시관";
    }
    
}