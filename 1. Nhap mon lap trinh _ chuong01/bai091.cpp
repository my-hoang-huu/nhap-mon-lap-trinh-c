#include<iostream>

using namespace std;
int main()
{
	int n;
	cout << "nhap n: " ;
	cin >> n;
	int x;
	cout << "nhap x: ";
	cin >> x;
	float S = -1;
	int T = 1;
	int M = 1;
	int dau = 1;
	int i = 2;
	while (i <= 2 * n)
	{
		T = T * x * x;
		M = M * i * (i - 1);
		S = S + 1.0 * dau * T / M;
		i = i + 2;
		dau = -dau;
	}
	cout << "Gia tri day so la: " << S << endl;
	system("pause");

	return 1;
}