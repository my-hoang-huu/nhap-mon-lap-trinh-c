﻿#include<iostream>
#include<iomanip>
#include<cstdlib>
#include<ctime>
using namespace std;
void Nhap(int[][50], int&, int&);
void Xuat(int[][50], int, int);
bool Kt(int);
void XuLy(int[][50], int, int);

int main()
{
	int a[20][50];
	int m;
	int n;
	Nhap(a, m, n);
	cout << "Ma tran ban dau: \n";
	Xuat(a, m, n);
	XuLy(a, m, n);
	cout << endl;
	return 1;
}
void Nhap(int a[][50], int& m, int& n)
{
	cout << "Nhap so dong m = ";
	cin >> m;
	cout << "\nNhap so cot n = ";
	cin >> n;
	srand(time(NULL));
	for (int i = 0; i < m; i++)
	{
		for (int j = 0; j < n; j++)
		{
			a[i][j] = rand() % 201 - 100;
	/*			cout << setw(7) << "a[" << i << "]" << "[" << j << "] = ";
				cin >> a[i][j];*/
		}
	}
	cout << endl;
}
void Xuat(int a[][50], int m, int n)
{
	for (int i = 0; i < m; i++)
	{
		cout << endl;
		for (int j = 0; j < n; j++)
		{
			cout << setw(8) << "a[" << i << "][" << j << "] = " << a[i][j];
		}
	}
	cout << endl;
}
bool Kt(int n)
{
	int t = n;
	int dn = 0;
	for (; t != 0; t = t / 10)
	{
		dn = dn * 10 + t % 10;
	}
	if (dn == n)
	{
		return true;
	}
	return false;
}
void XuLy(int a[][50], int m, int n)
{
	int d;
	cout << "\nNhap dong so: ";
	cin >> d;
	int s = 0;
	cout << "\nCac so doi xung tai dong " << d << " : ";
	cout << "\n";
	for (int j = 0; j < n; j++)
	{
		if (Kt(a[d][j]))
		{
			s = s + a[d][j];
			cout << setw(8) << "a[" << d << "][" << j << "] = " << a[d][j];
		}
	}
	cout << "\nTong cac so doi xung tai dong " << d << " : " << s;
}
