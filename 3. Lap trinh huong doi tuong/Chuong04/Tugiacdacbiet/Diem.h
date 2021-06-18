#include<iostream>
using namespace std;
#pragma once
#define PI atan(1) * 4

class Diem
{
private:
	float x;
	float y;
public:
	Diem() : x(), y() {}
	Diem(float xx, float yy) : x(xx), y(yy) {}
	Diem(float xx) : x(xx), y(0) {}
	Diem(const Diem& p) : x(p.x), y(p.y) {}
	Diem operator= (const Diem&);
	void Nhap();
	void Xuat();
	float GetX() { return x; }
	float GetY() { return y; }
	void SetX(float a) { x = a; }
	void SetY(float b) { y = b; };
	void SetXY(float a, float b) { x = a; y = b; }
	bool operator ==(const Diem&);
	bool operator !=(const Diem&);
	float KhoangCachGoc();
	float KhoangCach(const Diem&);
	float KhoangCachX(const Diem&); //Khoang cach 2 diem theo phuong X
	float KhoangCachY(const Diem&);
	Diem DoiXungTung();
	friend istream& operator>>(istream&, Diem&);
	friend ostream& operator<<(ostream&, Diem&);
	Diem TinhTien(float, float);
	Diem Quay(float);
	Diem QuayI(Diem, float);
	Diem Vector(Diem);
	bool VectorSongsong(Diem, Diem, Diem);
	bool isBaDiemThangHang(Diem, Diem);
	~Diem() { return; }
};

