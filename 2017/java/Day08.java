import java.io.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day08 {
	

	public static void main(String args[]) {
		try {
			Map<String, BiPredicate<Integer, Integer>> comparisons = new HashMap<>();
			comparisons.put("==", (x, y) -> x.equals(y));
			comparisons.put("!=", (x, y) -> !x.equals(y));
			comparisons.put("<", (x, y) -> x < y);
			comparisons.put(">", (x, y) -> x > y);
			comparisons.put("<=", (x, y) -> x <= y);
			comparisons.put(">=", (x, y) -> x >= y);
			Map<String, ToIntBiFunction<Integer, Integer>> commands = new HashMap<>();
			commands.put("inc", (x, y) -> x + y);
			commands.put("dec", (x, y) -> x - y);
			Scanner in = new Scanner(new File("d08.in"));
			Map<String, Integer> registers = new HashMap<>();
			int max = 0;
			while(in.hasNext()) {
				String line = in.nextLine();
				String[] tokens = line.split("\\s");
				String reg = tokens[0];
				String command = tokens[1];
				String testReg = tokens[4];
				String comparison = tokens[5];
				int amount = Integer.parseInt(tokens[2]);
				int testAmount = Integer.parseInt(tokens[6]);
				registers.putIfAbsent(reg, 0);
				if (comparisons.get(comparison).test(registers.getOrDefault(testReg, 0), testAmount)) {
					int current = registers.get(reg);
					registers.put(reg, commands.get(command).applyAsInt(current, amount));
					if (registers.get(reg) > max) {
						max = registers.get(reg);
					}
				}
			}
			System.out.println("P1: " + Collections.max(registers.values()));
			System.out.println("P2: " + max);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
