public class Day03 {

	public static void main(String args[]) {
		try {
			int input = 325489;
			int spiralValue = 1;
			int ring = 0;
			while (spiralValue < input) {
				ring++;
				spiralValue += ring * 8;
			}
			int extra = spiralValue - input;
			int p1 = input <= 1 ? 0 : ring + Math.abs(ring - (extra % (ring * 2)));	

			System.out.println("P1: " + p1);

			int n = (int) Math.ceil((Math.sqrt(input)-1)/2);
			int size = 2 * n + 1;
			long[][] spiral = new long[size][size];

			for (int i = 0; i < size; i++) {
				for (int j = 0; j < size; j++) {
					spiral[i][j] = 0;
				}
			}

			spiral[n][n] = 1;
			int direction = 0;
			int horizontal = n;
			int vertical = horizontal;
			int steps = 1;

			while (spiral[horizontal][vertical] <= input) {
				for (int i = 0; i < 2 && spiral[horizontal][vertical] <= input; i++) {
					for (int j = 0; j < steps && spiral[horizontal][vertical] <= input; j++) {
						switch (direction % 4) {
							case 0:
								++horizontal;
								break;
							case 1:
								--vertical;
								break;
							case 2:
								--horizontal;
								break;
							case 3:
								++vertical;
								break;
						}
						for (int x = -1; x <= 1; x++) {
							for (int y = -1; y <= 1; y++) {
								spiral[horizontal][vertical] += (testBoundary(size, horizontal, vertical, x, y) ? spiral[horizontal+x][vertical+y] : 0);
							}
						}
					}
					direction++;
				}
				steps++;
			}
			long p2 = spiral[horizontal][vertical];
			System.out.println("P2: " + p2);

		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	private static boolean testBoundary(int size, int horizontal, int vertical, int x, int y) {
		return !((x == 0 && y == 0) || horizontal + x < 0 || horizontal + x >= size || vertical + y < 0 || vertical + y > size - 1);
	}
}
