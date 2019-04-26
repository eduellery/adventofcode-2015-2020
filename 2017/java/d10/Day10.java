package d10;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day10 {

	private static int MAX = 256;
	private static Integer[] suffix = { 17, 31, 73, 47, 23 };

	public static void main(String args[]) {
		try {
			IntStream list = IntStream.range(0, MAX);
			IntStream hash = IntStream.range(0, MAX);
			List<Integer> lengths = Arrays.stream(Files.lines(Paths.get("d10/day10.in")).findFirst().get().split(",")).mapToInt(Integer::valueOf).boxed().collect(Collectors.toList());
			byte[] bytes = Files.readAllBytes(Paths.get("d10/day10.in"));
			List<Integer> fullLengths = IntStream.concat(
					IntStream.range(0, bytes.length).map(i -> bytes[i]),
					Arrays.asList(suffix).stream().mapToInt(Integer::intValue))
				.boxed().collect(Collectors.toList());
			list = sparseHash(list, lengths, 1);
			hash = sparseHash(hash, fullLengths, 64);
			System.out.println("P1: " + list.limit(2).reduce(1, (a, b) -> a * b));
			System.out.println("P2: " + denseHash(hash).collect(Collectors.joining("")));
		} catch(Exception e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}
	}

	public static IntStream sparseHash(IntStream list, List<Integer> lengths, int rounds) {
			int current = 0;
			int skip = 0;
			for (int round = 0; round < rounds; round++) {
				for (int length : lengths) {
					list = reverseOrderStream(list, current, length);
					current = (current + length + skip) % MAX;
					skip++;
				}
			}
			return list;
	}

	public static Stream<String> denseHash(IntStream hash) {
		List<Integer> list = hash.boxed().collect(Collectors.toList());
		return IntStream.range(0, (MAX + 15) >> 4)
			.mapToObj(i -> list.subList(i << 4, Math.min((i + 1) << 4, MAX)).stream().reduce((a, b) -> a ^ b).orElse(0))
			.map(i -> String.format("%02X", i).toLowerCase());
	}

	public static IntStream reverseOrderStream(IntStream intStream, int current, int length) {
		int[] tempArray = intStream.toArray();
		return IntStream.range(0, MAX).boxed().mapToInt(i -> shouldReverse(i, current, length) ? tempArray[(2 * current + MAX - i - 1 + length) % MAX] : tempArray[i]);
	}

	public static boolean shouldReverse(int idx, int current, int length) {
		return length > 1 && idx < current + length && (idx >= current || (current + length > MAX && idx < (current + length) % MAX));
	}
}
