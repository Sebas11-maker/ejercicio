package com.distr.uce.controller

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
class HelloWorld() {

    @GetMapping
    fun helloWorldGet() : String {
        return "Hello, World!"
    }
}
