﻿#include<iostream>
#include<iomanip>
#include<cstdlib>
#include<ctime>
using namespace std;
void Nhap(int[][100], int&, int&);
void Xuat(int[][100], int, int);
bool Kt(int);
void XuLy(int[][100], int, int);

int main()
{
	int a[20][100];
	int m;
	int n;
	Nhap(a, m, n);
	cout << "Ma tran ban dau: \n";
	Xuat(a, m, n);
	XuLy(a, m, n);
	cout << endl;
	return 1;
}
void Nhap(int a[][100], int& m, int& n)
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
			/*	cout << setw(7) << "a[" << i << "]" << "[" << j << "] = ";
				cin >> a[i][j];*/
		}
	}
	cout << endl;
}
void Xuat(int a[][100], int m, int n)
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
	if (n % 2 ==0)
	{
		return true;
	}
	return false;
}
void XuLy(int a[][100], int m, int n)
{
	int c;
	cout << "\nNhap cot so: ";
	cin >> c;
	int t = 1;
	cout << "\nCac so chan tai cot " << c << " : ";
	cout << "\n";
	int flag = 0;
	for (int i = 0; i < m; i++)
	{
		if (Kt(a[i][c]))
		{
			flag = 1;
			t = t * a[i][c];
			cout << setw(8) << "a[" << i << "][" << c << "] = " << a[i][c] << endl;
		}
	}
	if(flag == 0)
		cout << "\nKhong co so chan tai cot " << c;
	else
		cout << "\nTich cac so chan tai cot " << c << " : " << t;
}
