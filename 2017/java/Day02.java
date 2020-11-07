import java.io.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day02 {

	public static void main(String args[]) {
		try {
			Scanner in = new Scanner(new File("d02.in"));
			int sum1 = 0;
			int sum2 = 0;
			while(in.hasNext()) {
				String line = in.nextLine();
				Supplier<IntStream> supplier = () -> Arrays.stream(line.split("\\t")).mapToInt(Integer::valueOf);
				IntSummaryStatistics stats = supplier.get().summaryStatistics();
				sum1 += stats.getMax() - stats.getMin();
				sum2 += supplier.get().flatMap(i -> supplier.get().filter(j -> j != i && j % i == 0).map(j -> j / i)).findFirst().getAsInt();
			}
			System.out.println("P1: " + sum1);
			System.out.println("P2: " + sum2);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
