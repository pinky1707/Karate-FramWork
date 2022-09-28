package apis;

import org.junit.jupiter.api.Test;
import com.intuit.karate.Runner;

public class TestParallel {
	@Test
	public void testParallel() {
		Runner.path("classpath:apis").parallel(5);
	}

}
