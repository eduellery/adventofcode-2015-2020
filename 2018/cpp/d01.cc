#include <iostream>

using namespace std;
using ll = int64_t;

int main() {
  ll result = 0;
  string line;
  while (getline(cin, line)) {
    result += stoi(line);
  }
  cout << result << endl;
}
