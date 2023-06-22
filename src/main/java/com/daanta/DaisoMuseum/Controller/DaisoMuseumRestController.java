package com.daanta.DaisoMuseum.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

/**
 * DaisoMuseumController
 */
@Slf4j
@RestController
@RequestMapping("/rest")
public class DaisoMuseumRestController {

    @GetMapping({"", "index"})
    public String index2() {
        log.debug("rest/index");
        return "전시관";
    }
    
}