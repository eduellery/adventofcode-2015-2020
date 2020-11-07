package d11;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day11 {

	enum HexDir {
		n(0, -1), ne(1, -1), se(1, 0), s(0, 1), sw(-1, 1), nw(-1, 0);

		int dx, dy;

		HexDir(int dx, int dy) {
			this.dx = dx;
			this.dy = dy;
		}
	}

	public static void main(String args[]) {
		try {
			String[] directions = Files.lines(Paths.get("d11/day11.in")).findFirst().get().split(",");
			int x = 0;
			int y = 0;
			int dist = 0;
			int furthest = 0;
			for (String direction : directions) {
				HexDir current = HexDir.valueOf(direction);
				x += current.dx;
				y += current.dy;
				dist = hexDist(x, y);
				if (dist > furthest) {
					furthest = dist;
				}
			}
			System.out.println("P1: " + dist);
			System.out.println("P2: " + furthest);
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}
	}

	private static int hexDist(int x, int y) {
		return (Math.abs(x) + Math.abs(y) + Math.abs(x + y))/2;
	}

}
