#include<iostream>
using namespace std;
int main()
{
	int i = 2, n;
	cout << "nhap n: ";
	cin >> n;
	float S = 0;
	while (i <= 2*n)
	{
		S = S + 1.0 / i;
		i = i + 2;
	}
	cout << "tong day so la: " << S << endl;
	system("pause");

	return 1;

}