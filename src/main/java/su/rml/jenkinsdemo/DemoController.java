package su.rml.jenkinsdemo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @Value("${foo.bar}")
    private String foo;

    @GetMapping
    public String hello() {
        return foo;
    }
}
