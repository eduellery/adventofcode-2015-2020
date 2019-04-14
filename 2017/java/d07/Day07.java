package d07;

import java.io.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day07 {

	public static void main(String args[]) {
		try {
			Scanner in = new Scanner(new File("d07/day07.in"));
			String p1 = null;
			List<String> all = new ArrayList();
			List<String> nonRoot = new ArrayList();
			while(in.hasNext()) {
				String line = in.nextLine();
				Supplier<Stream<String>> supplier = () -> Arrays.stream(line.split(",\\s|\\s"));
				all.add(supplier.get().findFirst().get());
				supplier.get().skip(3).forEach(nonRoot::add);
			}
			for (String value : all) {
				if (!nonRoot.contains(value)) {
					p1 = value;
					break;
				}
			}
			System.out.println("P1: " + p1);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
