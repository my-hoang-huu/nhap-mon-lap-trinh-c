﻿#include<iostream>
#include<iomanip>
#include<cstdlib>
#include<ctime>
using namespace std;
void Nhap(float[][50], int&, int&);
void Xuat(float[][50], int, int);
bool Kt(float);
void XuLy(float[][50], int, int);
int main()
{
	float a[20][50];
	int m;
	int n;
	Nhap(a, m, n);
	cout << "Ma tran ban dau: \n";
	Xuat(a, m, n);
	XuLy(a, m, n);
	return 1;
}
void Nhap(float a[][50], int& m, int& n)
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
			a[i][j] = rand() % 21 - 10;
			/*	cout << setw(7) << "a[" << i << "]" << "[" << j << "] = ";
				cin >> a[i][j];*/
		}
	}
	cout << endl;
}
void Xuat(float a[][50], int m, int n)
{
	for (int i = 0; i < m; i++)
	{
		cout << endl;
		for (int j = 0; j < n; j++)
		{
			cout << setw(8) << "a[" << i << "][" << j << "] = " << fixed << setprecision(2) << a[i][j];
		}
	}
	cout << endl;
}
bool Kt(float n)
{
	return true;
}
void XuLy(float a[][50], int m, int n)
{
	float x;
	cout << "\nNhap x: ";
	cin >> x;
	cout << "\nCac vi tri chua so co gia tri bang " << x << " : ";
	int dem = 0;
	for (int i = 0; i < m; i++)
	{
		cout << "\n";
		for (int j = 0; j < n; j++)
		{
			if (a[i][j] == x)
			{
				dem++;
				cout << setw(8) << "a[" << i << "][" << j << "] = " << fixed << setprecision(2) << a[i][j];
			}
		}
	}
	cout << "\nSo luong cac so co gia tri bang " << x << " : " << dem << endl;
}