﻿#include<iostream>
#include<iomanip>
#include<cstdlib>
#include<ctime>
using namespace std;
void Nhap(int[][50], int&, int&);
void Xuat(int[][50], int, int);
void HoanVi(int&, int&);
void XuLy(int[][50], int, int);
void MangPhuTang(int[][50], int, int);
void MangPhuGiam(int[][50], int, int);
void MangPhu(int[][50], int, int);
void TangMang(int[], int);
void GiamMang(int[], int);

int main()
{
	int a[20][50];
	int m;
	int n;
	Nhap(a, m, n);
	cout << "Ma tran ban dau: \n";
	Xuat(a, m, n);
	int t = m * n;
	XuLy(a, n, t);
	cout << "\nMa tran sau khi sap tang so chan va sap giam so le :\nCach 1: ";
	Xuat(a, m, n);
	cout << "\nCach 2 (dung mang phu): ";
	MangPhuTang(a, m, n);
	Xuat(a, m, n);
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
			/*	cout << setw(7) << "a[" << i << "]" << "[" << j << "] = ";
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
			cout << setw(8) << "a[" << i << "][" << j << "] = " << fixed << setprecision(2) << a[i][j];
		}
	}
	cout << endl;
}
void HoanVi(int& x, int& y)
{
	int temp = x;
	x = y;
	y = temp;
}

void XuLy(int a[][50], int n, int t)
{
	if (t <= 1)
		return;
	if (a[(t - 1) / n][(t - 1) % n] % 2 == 0)
	{
		for (int k = 0; k <= t - 2; k++)
		{
			if (a[k / n][k % n] > a[(t - 1) / n][(t - 1) % n] && a[k / n][k % n] % 2 == 0)
			{
				HoanVi(a[k / n][k % n], a[(t - 1) / n][(t - 1) % n]);
			}
		}
	}
	if (a[(t - 1) / n][(t - 1) % n] % 2 != 0)
	{
		for (int k = 0; k <= t - 2; k++)
		{
			if (a[k / n][k % n] < a[(t - 1) / n][(t - 1) % n] && a[k / n][k % n] % 2 != 0)
			{
				HoanVi(a[k / n][k % n], a[(t - 1) / n][(t - 1) % n]);
			}
		}
	}
	XuLy(a, n, t - 1);
}
void TangMang(int a[], int n)
{
	if (n < 2)
		return;
	for (int i = 0; i <= n - 2; i++)
	{
		if (a[n - 1] < a[i])
			HoanVi(a[n - 1], a[i]);
	}
	TangMang(a, n - 1);
}
void GiamMang(int a[], int n)
{
	if (n < 2)
		return;
	for (int i = 0; i <= n - 2; i++)
	{
		if (a[n - 1] > a[i])
			HoanVi(a[n - 1], a[i]);
	}
	GiamMang(a, n - 1);
}
void MangPhuTang(int a[][50], int m, int n)
{
	int b[1000];
	int k = 0;
	for (int i = 0; i < m; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (a[i][j] % 2 == 0)
				b[k++] = a[i][j];
		}
	}
	TangMang(b, k);
	k = 0;
	for (int i = 0; i < m; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (a[i][j] % 2 == 0)
				a[i][j] = b[k++];
		}
	}
}
void MangPhuGiam(int a[][50], int m, int n)
{
	int b[1000];
	int k = 0;
	for (int i = 0; i < m; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (a[i][j] % 2 != 0)
				b[k++] = a[i][j];
		}
	}
	GiamMang(b, k);
	k = 0;
	for (int i = 0; i < m; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (a[i][j] % 2 != 0)
				a[i][j] = b[k++];
		}
	}
}
void MangPhu(int a[][50], int m, int n)
{
	MangPhuTang(a, m, n);
	MangPhuGiam(a, m, n);
}
