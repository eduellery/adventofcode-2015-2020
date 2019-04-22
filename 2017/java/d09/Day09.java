package d09;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;

public class Day09 {

	enum State {
		OPEN, CLOSE, GARBAGE, IGNORE, OTHER;

		final Map<Character, State> transitions = new HashMap<>();

		static {
			State.OTHER.addTransition('{', State.OPEN);
			State.OTHER.addTransition('}', State.CLOSE);
			State.OTHER.addTransition('<', State.GARBAGE);
			State.OPEN.addTransition('}', State.CLOSE);
			State.OPEN.addTransition('<', State.GARBAGE);
			State.OPEN.addTransition(',', State.OTHER);
			State.CLOSE.addTransition('{', State.OPEN);
			State.CLOSE.addTransition('<', State.GARBAGE);
			State.CLOSE.addTransition(',', State.OTHER);
			State.GARBAGE.addTransition('!', State.IGNORE);
			State.GARBAGE.addTransition('>', State.OTHER);
			State.IGNORE.addTransition('!', State.GARBAGE);
		}

		private void addTransition(char c, State accept) {
			transitions.put(c, accept);
		}

		public State getTransition(char c) {
			return transitions.getOrDefault(c, this);
		}
	}

	public static void main(String args[]) {
		try {
			Machine m = new Machine();
			Stream<Character> stream = Files.lines(Paths.get("d09/day09.in")).findFirst().get().chars().mapToObj(c -> (char) c);
			stream.forEach(c -> {
				State current = m.getState();
				if (current == State.IGNORE) {
					c = '!';
				}
				State next = current.getTransition(c);
				switch (next) {
					case OPEN:
						m.incLevel();
						break;
					case CLOSE:
						m.addScore(m.decLevel());
						break;
				}
				m.setState(next);
			});
			System.out.println("P1: " + m.getScore());
		} catch(Exception e) {
			System.err.println(e.getMessage());
		}
	}

	private static class Machine {

		private State state = State.OTHER;
		private int level = 0;
		private int score = 0;

		public State getState() {
			return this.state;
		}

		public void setState(State state) {
			this.state = state;
		}

		public int incLevel() {
			return this.level++;
		}

		public int decLevel() {
			return this.level--;
		}

		public void addScore(int value) {
			this.score += value;
		}

		public int getScore() {
			return this.score;
		}
	}
}
