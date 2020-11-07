package d04;

import java.io.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day04 {

	public static void main(String args[]) {
		try {
			Scanner in = new Scanner(new File("d04/day04.in"));
			int p1 = 0;
			int p2 = 0;
			while(in.hasNext()) {
				String line = in.nextLine();
				Supplier<Stream<String>> supplier = () -> Arrays.stream(line.split("\\s"));
				p1 += supplier.get().count() == supplier.get().distinct().count() ? 1 : 0;
				p2 += supplier.get().count() == supplier.get().map(str -> str.chars().sorted().collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString()).distinct().count() ? 1 : 0;
			}
			System.out.println("P1: " + p1);
			System.out.println("P2: " + p2);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
