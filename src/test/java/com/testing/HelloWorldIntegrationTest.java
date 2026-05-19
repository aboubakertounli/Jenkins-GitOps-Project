package com.testing;

import static com.testing.HelloWorldController.MESSAGE_KEY;
import static org.assertj.core.api.Assertions.assertThat;

import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.ResponseEntity;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
public class HelloWorldIntegrationTest {

    @LocalServerPort
    int port;

    @Autowired
    private TestRestTemplate template;

    @Test
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void responseShouldContainHelloWorldKey() {
        String url = "http://localhost:" + port + "/";

        ResponseEntity<Map> response = template.getForEntity(url, Map.class);
        Map<String, String> result = response.getBody();

        assertThat(result.containsKey(MESSAGE_KEY)).isTrue();
        assertThat(result.get(MESSAGE_KEY)).isEqualTo("Hello World!");
    }
}
