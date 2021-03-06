﻿#include<iostream>
#include<iomanip>
using namespace std;
void Nhap(float[], int&);
void Xuat(float[], int);
float Min(float[], int);


int main()
{
	float a[100];
	int n;
	Nhap(a, n);
	Xuat(a, n);
	cout << "\nGia tri Nho nhat trong mang ban dau: \n" << Min(a, n) << endl;
	return 1;
}
void Nhap(float a[], int& n)
{
	cout << "Nhap so phan tu mang: ";
	cin >> n;
	srand(time(NULL));
	for (int i = 0; i < n; i++)
		a[i] = rand() * 1.0 / RAND_MAX * 200.0 - 100.0;
}
void Xuat(float a[], int n)
{
	for (int i = 0; i < n; i++)
	{
		cout << a[i] << setw(10);
	}
	cout << endl;
}
float Min(float a[], int n)
{
	float lc = a[0];
	for (int i = 1; i < n; i++)
	{
		if (a[i] < lc)
		{
			lc = a[i];
		}
	}
	cout << "\nCac Vi tri tai do co gia tri nho nhat trong mang: \n";
	for (int i = 0; i < n; i++)
	{
		if (lc == a[i])
		{
			cout << i << setw(5);
		}
	}
	return lc;
}
