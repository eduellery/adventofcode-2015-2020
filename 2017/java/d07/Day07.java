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
			Map<Disc, Disc> discs = new HashMap(); // Silly but useful as Set doesn't have a get.
			while(in.hasNext()) {
				String line = in.nextLine();
				Supplier<Stream<String>> supplier = () -> Arrays.stream(line.split(",\\s|\\s"));
				String current = supplier.get().findFirst().get();
				all.add(current);
				supplier.get().skip(3).forEach(nonRoot::add);
				Disc created = new Disc(current);
				Disc existing = discs.get(created);
				Disc disc = existing == null ? created : existing;
				disc.setWeight(supplier.get().skip(1).map(str -> str.replaceAll("[()]", "")).mapToInt(Integer::parseInt).findFirst().getAsInt());
				discs.put(disc, disc);
				supplier.get().skip(3).forEach(entry -> {
					Disc child = new Disc(entry);
					Disc temp = discs.get(child);
					child = temp == null ? child : temp;
					discs.put(child, child);
					disc.addChild(child);
				});
			}
			for (String value : all) {
				if (!nonRoot.contains(value)) {
					p1 = value;
					break;
				}
			}
			System.out.println("P1: " + p1);
			System.out.println("P2: " + fixedValue(discs.get(new Disc(p1))));
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	private static int fixedValue(Disc disc) {
		Disc grandpa = null;
		Disc dad = null;
		do {
			grandpa = dad;
			dad = disc;
			disc = getFaultyDisc(disc);
		} while (disc != null);
		int fault = dad.getTotalWeight();
		int correct = grandpa.getChildren().stream().filter(i -> i.getTotalWeight() != fault).findFirst().get().getTotalWeight();
		int fix = correct - fault;
		return dad.getWeight() + fix;
	}

	private static Disc getFaultyDisc(Disc disc) {
		Supplier<Stream<Disc>> supplier = () -> disc.getChildren().stream();
	        Optional<Disc> different = supplier.get().flatMap(i -> supplier.get().filter(j -> i.getTotalWeight() != j.getTotalWeight())).findFirst();
		return different.orElse(null);
	}

	private static class Disc {

		private String name = null;
		private int weight = 0;
		private List<Disc> children = new ArrayList();

		public Disc (String name) {
			this.name = name;
		}

		public void setWeight(int weight) {
			this.weight = weight;
		}

		public void addChild(Disc disc) {
			this.children.add(disc);
		}

		public String getName() {
			return this.name;
		}

		public int getWeight() {
			return this.weight;
		}

		public List<Disc> getChildren() {
			return children;
		}

		public int getTotalWeight() {
			return children.size() == 0 ? weight : weight + children.stream().mapToInt(i -> i.getTotalWeight()).sum();
		}

		@Override
		public boolean equals(Object o) {
			if (o == this) {
				return true;
			}
			if (!(o instanceof Disc)) {
				return false;
			}
			Disc d = (Disc) o;
			return this.name.equals(d.getName());
		}

		@Override
		public int hashCode() {
			return this.name != null ? this.name.hashCode() : 0;
		}
	}
}
