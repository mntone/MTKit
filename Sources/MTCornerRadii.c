#include "MTCornerRadii.h"

bool MTCornerRadiiIsNull(MTCornerRadii cornerRadii) {
	return !(cornerRadii.topLeft >= 0.01 || cornerRadii.topRight >= 0.01 || cornerRadii.bottomLeft >= 0.01 || cornerRadii.bottomRight >= 0.01);
}
