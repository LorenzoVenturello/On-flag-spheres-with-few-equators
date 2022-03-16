## This is the function to check if an induced subcomplex that is not the link of a vertex is of codim 1 and it has the weak pseudomanifold property.
## If the output is the empty list, then there are no non-trivial equators. If the output contain some complex than you can check by hand if that is an homology sphere.
## Below the function there is an example of how to run it
## WARNING: You need to replace the line "S.generated_subcomplex(i).dimension() == 2" with "S.generated_subcomplex(i).dimension() == d-1", where d is the dimension of your input complex.

def check_links(S,V,P):
    N=[]
    for i in P:
        c=0
        for j in V:
            if set(j).issubset(set(i)):
                c=c+1
            if set(i).issubset(set(j)):
                c=c+1    
        if c==0 and S.generated_subcomplex(i).dimension() == 2 and S.generated_subcomplex(i).is_pseudomanifold():
            N.append(i)
    return N

## Function to contract the edge of a simplicial complex. The input l is meant to be a list of forbidden edges, you can forget about it and use l = [].

def edge_contraction(S, e, l):
	V = SimplicialComplex(l).vertices()
	k = 0
	if e[1] in V:
		k = 1
	F = S.facets()
	NF = []
	for f in F:
		if set(e).issubset(set(f)) == False:
			if k == 0:
				if set([e[1]]).issubset(set(f)):
					NF.append(set(f)-set([e[1]])|set([e[0]]))
				else:
					NF.append(set(f))
			if k == 1:
				if set([e[0]]).issubset(set(f)):
					NF.append(set(f)-set([e[0]])|set([e[1]]))
				else:
					NF.append(set(f))
	return SimplicialComplex(NF) 


## Say S is the simplicial sphere you want to test
P = subsets(S.vertices())

## In the next line you need to replace "7", with 2(dim(S)-1)-1. This is the lowest number of vertices a flag codimension 1 sphere in S can have

P1 = [i for i in P if len(i)>5]
VLINKS = [list(S.link([i]).vertices()) for i in S.vertices()]
CHL = check_links(S,VLINKS,P1)
