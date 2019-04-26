package d10;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day10 {

	private static int MAX = 256;

	public static void main(String args[]) {
		try {
			IntStream list = IntStream.range(0, MAX);
			List<Integer> lengths = Arrays.stream(Files.lines(Paths.get("d10/day10.in")).findFirst().get().split(",")).mapToInt(Integer::valueOf).boxed().collect(Collectors.toList());
			int current = 0;
			int skip = 0;
			for (int length : lengths) {
				list = reverseOrderStream(list, current, length);
				current = (current + length + skip) % MAX;
				skip++;
			}
			System.out.println("P1: " + list.limit(2).reduce(1, (a, b) -> a * b));
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static IntStream reverseOrderStream(IntStream intStream, int current, int length) {
		int[] tempArray = intStream.toArray();
		return IntStream.range(0, MAX).boxed().mapToInt(i -> shouldReverse(i, current, length) ? tempArray[(2 * current + MAX - i - 1 + length) % MAX] : tempArray[i]);
	}

	public static boolean shouldReverse(int idx, int current, int length) {
		return length > 1 && idx < current + length && (idx >= current || (current + length > MAX && idx < (current + length) % MAX));
	}
}
