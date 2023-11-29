import static org.junit.Assert.*;
import org.junit.*;

import java.beans.Transient;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test
  public void testFilter() {
    List<String> str = Arrays.asList("apple", "banana", "grape", "cherry");
    StringChecker sc = s -> s.contains("a");
    List<String> filtered = ListExamples.filter(str, sc);
    List<String> expected = Arrays.asList("apple", "banana", "grape");
    assertEquals(expected, filtered);
  }
}
