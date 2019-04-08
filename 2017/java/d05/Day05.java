package d05;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day05 {

	public static void main(String args[]) {
		try {
			Stream<String> stream = Files.lines(Paths.get("d05/day05.in"));
			Supplier<Stream<String>> supplier = () -> stream;
			int[] values = supplier.get().mapToInt(Integer::parseInt).toArray();
			int p1 = 0, idx = 0;
			int[] p1Values = values.clone();
			while (idx < p1Values.length && idx >= 0) {
				int jump = p1Values[idx]++;
				idx += jump;
				p1++;
			}
			System.out.println("P1: " + p1);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
