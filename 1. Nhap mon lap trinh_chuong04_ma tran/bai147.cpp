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
			a[i][j] = rand() * 1.0 / RAND_MAX * 200 - 100;
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
bool Kt(float a[][50], int m, int c)
{
	int flag = 0;
	for (int i = 0; i < m; i++)
		if (a[i][c] > 0)
			return false;
	return true;		
}
void XuLy(float a[][50], int m, int n)
{
	int flag = 0;
	for (int c = n - 1; c >= 0; c--)
	{
		if (Kt(a, m, c))
		{
			n--;
			flag = 1;
			for (int i = 0; i < m; i++)
			{
				for (int j = c; j < n; j++)
				{
					a[i][j] = a[i][j + 1];
				}
			}
		}
	}
	if (flag == 0)
		cout << "\nMa tran khong co cot toan am.\n";
	else
	{
		cout << "\nMa tran sau khi xoa cot toan am:";
		Xuat(a, m, n);
	}
}