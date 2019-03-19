package d03;

public class Day03 {

	public static void main(String args[]) {
		try {
			int input = 325489;
			int spiral = 1;
			int ring = 0;
			while (spiral < input) {
				ring++;
				spiral += ring * 8;
			}
			int extra = spiral - input;
			int p1 = input <= 1 ? 0 : ring + Math.abs(ring - (extra % (ring * 2)));	
			System.out.println("P1: " + p1);
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}
}
