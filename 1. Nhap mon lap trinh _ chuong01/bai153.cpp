#include<iostream>
using namespace std;
int main()
{
	int n;
	cout << "nhap n: ";
	cin >> n;
	int t = 1;
	int i = 0;
	int flag = 0;
	while (t <= n)
	{
		if (t == n)
		{
			cout << "So nguyen " << n << " co dang 5^" << i << endl;
			flag = 1;
		}
		t = t * 5;
		i = i + 1;
	}
	if (flag == 0)
	{
		cout << "So nguyen " << n << " khong co dang 5^k" << endl;
	}

	system("pause");
	return 1;
}
