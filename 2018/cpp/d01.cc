#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;
using ll = int64_t;

int main() {
  vector<ll> data{istream_iterator<ll>{cin}, {}};
  ll result = 0, result1 = 0, result2 = 0;
  bool part1 = false, part2 = false;
  unordered_set<ll> my_set;

  while(!part2) {
    for (auto const& value: data) {
      result += value;
      if (!part2 && my_set.count(result) > 0) {
        part2 = true;
        result2 = result;
        break;
      } else {
        // cerr << "Adding " << result << endl;
        my_set.emplace(result);
      }
    }

    if (!part1) {
      part1 = true;
      result1 = result;
    }
  }

  cout << "P1: " << result1 << endl;
  cout << "P2: " << result2 << endl;
}
