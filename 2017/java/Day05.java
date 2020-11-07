import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day05 {

	public static void main(String args[]) {
		try {
			Stream<String> stream = Files.lines(Paths.get("d05.in"));
			Supplier<Stream<String>> supplier = () -> stream;
			int[] values = supplier.get().mapToInt(Integer::parseInt).toArray();
			int p1 = 0, idx = 0;
			int[] p1Values = values.clone();
			while (idx < p1Values.length && idx >= 0) {
				int jump = p1Values[idx]++;
				idx += jump;
				p1++;
			}
			int p2 = 0; idx = 0;
			int[] p2Values = values.clone();
			while (idx < p2Values.length && idx >= 0) {
				int jump = p2Values[idx];
				p2Values[idx] += jump >= 3 ? -1 : 1;
				idx += jump;
				p2++;
			}
			System.out.println("P1: " + p1);
			System.out.println("P2: " + p2);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
