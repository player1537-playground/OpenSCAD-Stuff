module fibonacci_sphere(r, n, $fn){
	assign(n = n==undef? ceil((0.5*$fn*$fn)/2) : n)
	hull()
	for(i=[-n:3:(n-2)]){
		polyhedron(points = [
			r * _pos(i,n),
			r * _pos(i+1,	n),
			r * _pos(i+2,n),
		], faces=[
			[0,1,2]
		]);
	}
}

//calculates ith vertex position on a fibonacci unit sphere of 2*n vertices
function _pos(i, n) =
	[cos(_lon(i)) * _xy(_z(i,n)), 
	 sin(_lon(i)) * _xy(_z(i,n)), 
	 _z(i,n)];

function _lon(i) = _golden_angle*i;
function _z(i,n) = 2*i/(2*n+1);
function _xy(z)  = sqrt(1-pow(z,2));

_golden_ratio = 1.61803;
_golden_angle = 360 * _golden_ratio; 
