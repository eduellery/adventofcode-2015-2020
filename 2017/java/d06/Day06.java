package d06;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day06 {

	public static void main(String args[]) {
		try {
			IntStream stream = Arrays.stream(Files.lines(Paths.get("d06/day06.in")).findFirst().get().split("\\s")).mapToInt(Integer::valueOf);
			Supplier<IntStream> supplier = () -> stream;
		        List<Integer> values = supplier.get().boxed().collect(Collectors.toList());
			HashMap<List<Integer>, Integer> seen = new HashMap<List<Integer>,Integer>();
			int p1 = 0;
			seen.put(values, p1);
			while (p1 < Integer.MAX_VALUE) {
				values = Arrays.stream(redistribute(values.stream().mapToInt(i -> i).toArray())).boxed().collect(Collectors.toList());
				p1++;
				if (seen.containsKey(values)) {
					break;
				}
				seen.put(values, p1);
			}
			int p2 = p1 - seen.get(values);
			System.out.println("P1: " + p1);
			System.out.println("P2: " + p2);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	private static int findIndexMaxValue(int[] values) {
		if (values == null || values.length == 0) {
			return -1;
		}
		int index = 0;
		int max = values[index];
		for (int i = 1; i < values.length; i++) {
			if (values[i] > max) {
				max = values[i];
				index = i;
			}
		}
		return index;
	}

	private static int[] redistribute(int[] values) {
		int length = values.length;
		int index = findIndexMaxValue(values);
		int max = values[index];
		values[index] = 0;
		for (int i = 1; i <= max; i++) {
			values[(index + i) % length]++;
		}
		return values;
	}
}
