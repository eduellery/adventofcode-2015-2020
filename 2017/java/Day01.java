import java.io.*;
import java.util.*;

public class Day01 {

	public static void main(String args[]) {
		try {
			Scanner in = new Scanner(new File("d01.in"));
			String input = in.nextLine();
			int sum1 = 0;
			int sum2 = 0;
			for (int i = 0; i < input.length() - 1; i++) {
				if (Character.getNumericValue(input.charAt(i)) == Character.getNumericValue(input.charAt(i + 1))) {
					sum1 += Character.getNumericValue(input.charAt(i));
				}
				if (Character.getNumericValue(input.charAt(i)) == Character.getNumericValue(input.charAt((i + (input.length() / 2)) % input.length()))) {
					sum2 += Character.getNumericValue(input.charAt(i));
				}
			}
			if (Character.getNumericValue(input.charAt(0)) == Character.getNumericValue(input.charAt(input.length() - 1))) {
				sum1 += Character.getNumericValue(input.charAt(0));
			}
			System.out.println("P1: " + sum1);
			System.out.println("P2: " + sum2);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
