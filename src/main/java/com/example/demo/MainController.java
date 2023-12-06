package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {
    @GetMapping("/start")
    public String msg()
    {
        return  "msg welcome";
    }

    @GetMapping("/message")
    public String me()
    {

        return  "message";
    }

}
