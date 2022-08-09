package conduit;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit4.Karate;
import org.junit.Test;
import org.junit.runner.RunWith;

import static org.junit.Assert.assertTrue;

public class ConduitRunner {

    @Test
    public void testParallel(){
        Results results = Runner.path("classpath:conduit/").parallel(1);
        assertTrue(results.getErrorMessages(),results.getFailCount() == 0);
    }
}
