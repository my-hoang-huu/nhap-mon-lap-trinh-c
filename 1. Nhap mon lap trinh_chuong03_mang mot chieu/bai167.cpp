﻿#include<iostream>
#include<iomanip>
using namespace std;
void Nhap(float[], int&);
void Xuat(float[], int);
float Kt(float[], int);
void Xuly(float[], int);

int main()
{
	float a[100];
	int n;
	cout << "Nhap mang a:";
	Nhap(a, n);
	Xuat(a, n);
	/*cout << "\nNhap x: ";
	int x;
	cin >> x;*/
	cout << "\n\nMang a sau khi xoa cac gia tri lap chi giu 1 gia tri : \n";
	Xuly(a, n);
	return 1;
}
void Nhap(float a[], int& n)
{
	cout << "\nNhap so phan tu mang: ";
	cin >> n;
	srand(time(NULL));
	for (int i = 0; i < n; i++)
	{
		cin >> a[i];
		//a[i] = rand() * 1.0 / RAND_MAX * 200 - 100;
		//a[i] = rand() % 21 - 10;
	}
}
void Xuat(float a[], int n)
{
	cout << "\nMang: ";
	for (int i = 0; i < n; i++)
	{
		cout << a[i] << setw(10);
	}
	cout << endl;
}
float Kt(float a[], int n)
{
	float max = a[0];
	for (int i = 1; i < n; i++)
	{
		if (a[i] > max)
		{
			max = a[i];
		}
	}
	return max;
}
void Xuly(float a[], int n)
{
	int k;
	int lc;
	for (k = 0; k < n - 1; k++)
	{
		for (int i = k + 1; i < n; i++)
		{
			if (a[i] == a[k])
			{
				//Can xoa a[i];
				for (int j = i; j < n; j++)
				{
					a[j] = a[j + 1];
				}
				i--;
				n--;
			}
		}
	}
	cout << "\nMang ket qua: ";
	Xuat(a, n);
}