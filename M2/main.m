p = .99;

[T99, sums] = transition(G, p, n);
[V, bad, badD, numone, P99] = eigen(T99, n);
[Ps99, ct99] = det_steady(T99, n);
[urls99, probs99] = det_urls(U, P99, n);
[urlss99, probss99] = det_urls(U, Ps99, n);

p = .95;

[T95, sums] = transition(G, p, n);
[V, bad, badD, numone, P95] = eigen(T95, n);
[Ps95, ct95] = det_steady(T95, n);
[urls95, probs95] = det_urls(U, P95, n);
[urlss95, probss95] = det_urls(U, Ps95, n);

p = .9;

[T90, sums] = transition(G, p, n);
[V, bad, badD, numone, P90] = eigen(T90, n);
[Ps90, ct90] = det_steady(T90, n);
[urls90, probs90] = det_urls(U, P90, n);
[urlss90, probss90] = det_urls(U, Ps90, n);

p = .87;

[T87, sums] = transition(G, p, n);
[V, bad, badD, numone, P87] = eigen(T87, n);
[Ps87, ct87] = det_steady(T87, n);
[urls87, probs87] = det_urls(U, P87, n);
[urlss87, probss87] = det_urls(U, Ps87, n);

p = .85;

[T85, sums] = transition(G, p, n);
[V, bad, badD, numone, P85] = eigen(T85, n);
[Ps85, ct85] = det_steady(T85, n);
[urls85, probs85] = det_urls(U, P85, n);
[urlss85, probss85] = det_urls(U, Ps85, n);

p = .83;

[T83, sums] = transition(G, p, n);
[V, bad, badD, numone, P83] = eigen(T83, n);
[Ps83, ct83] = det_steady(T83, n);
[urls83, probs83] = det_urls(U, P83, n);
[urlss83, probss83] = det_urls(U, Ps83, n);

p = .8;

[T80, sums] = transition(G, p, n);
[V, bad, badD, numone, P80] = eigen(T80, n);
[Ps80, ct80] = det_steady(T80, n);
[urls80, probs80] = det_urls(U, P80, n);
[urlss80, probss80] = det_urls(U, Ps80, n);

p = .75;

[T75, sums] = transition(G, p, n);
[V, bad, badD, numone, P75] = eigen(T75, n);
[Ps75, ct75] = det_steady(T75, n);
[urls75, probs75] = det_urls(U, P75, n);
[urlss75, probss75] = det_urls(U, Ps75, n);

p = .7;

[T70, sums] = transition(G, p, n);
[V, bad, badD, numone, P70] = eigen(T70, n);
[Ps70, ct70] = det_steady(T70, n);
[urls70, probs70] = det_urls(U, P70, n);
[urlss70, probss70] = det_urls(U, Ps70, n);

p = .5;

[T50, sums] = transition(G, p, n);
[V, bad, badD, numone, P50] = eigen(T50, n);
[Ps50, ct50] = det_steady(T50, n);
[urls50, probs50] = det_urls(U, P50, n);
[urlss50, probss50] = det_urls(U, Ps50, n);

p = .25;

[T25, sums] = transition(G, p, n);
[V, bad, badD, numone, P25] = eigen(T25, n);
[Ps25, ct25] = det_steady(T25, n);
[urls25, probs25] = det_urls(U, P25, n);
[urlss25, probss25] = det_urls(U, Ps25, n);

p = .01;

[T01, sums] = transition(G, p, n);
[V, bad, badD, numone, P01] = eigen(T01, n);
[Ps01, ct01] = det_steady(T01, n);
[urls01, probs01] = det_urls(U, P01, n);
[urlss01, probss01] = det_urls(U, Ps01, n);

p = .99;

[T99, sums] = transition2(G, p, n);
[V, bad, badD, numone, P99] = eigen(T99, n);
[Ps99, ct99] = det_steady(T99, n);
[urls99, probs99] = det_urls(U, P99, n);
[urlss99, probss99] = det_urls(U, Ps99, n);

p = .95;

[T95, sums] = transition2(G, p, n);
[V, bad, badD, numone, P95] = eigen(T95, n);
[Ps95, ct95] = det_steady(T95, n);
[urls95, probs95] = det_urls(U, P95, n);
[urlss95, probss95] = det_urls(U, Ps95, n);

p = .9;

[T90, sums] = transition2(G, p, n);
[V, bad, badD, numone, P90] = eigen(T90, n);
[Ps90, ct90] = det_steady(T90, n);
[urls90, probs90] = det_urls(U, P90, n);
[urlss90, probss90] = det_urls(U, Ps90, n);

p = .87;

[T87, sums] = transition2(G, p, n);
[V, bad, badD, numone, P87] = eigen(T87, n);
[Ps87, ct87] = det_steady(T87, n);
[urls87, probs87] = det_urls(U, P87, n);
[urlss87, probss87] = det_urls(U, Ps87, n);

p = .85;

[T85, sums] = transition2(G, p, n);
[V, bad, badD, numone, P85] = eigen(T85, n);
[Ps85, ct85] = det_steady(T85, n);
[urls85, probs85] = det_urls(U, P85, n);
[urlss85, probss85] = det_urls(U, Ps85, n);

p = .83;

[T83, sums] = transition2(G, p, n);
[V, bad, badD, numone, P83] = eigen(T83, n);
[Ps83, ct83] = det_steady(T83, n);
[urls83, probs83] = det_urls(U, P83, n);
[urlss83, probss83] = det_urls(U, Ps83, n);

p = .8;

[T80, sums] = transition2(G, p, n);
[V, bad, badD, numone, P80] = eigen(T80, n);
[Ps80, ct80] = det_steady(T80, n);
[urls80, probs80] = det_urls(U, P80, n);
[urlss80, probss80] = det_urls(U, Ps80, n);

p = .75;

[T75, sums] = transition2(G, p, n);
[V, bad, badD, numone, P75] = eigen(T75, n);
[Ps75, ct75] = det_steady(T75, n);
[urls75, probs75] = det_urls(U, P75, n);
[urlss75, probss75] = det_urls(U, Ps75, n);

p = .7;

[T70, sums] = transition2(G, p, n);
[V, bad, badD, numone, P70] = eigen(T70, n);
[Ps70, ct70] = det_steady(T70, n);
[urls70, probs70] = det_urls(U, P70, n);
[urlss70, probss70] = det_urls(U, Ps70, n);

p = .5;

[T50, sums] = transition2(G, p, n);
[V, bad, badD, numone, P50] = eigen(T50, n);
[Ps50, ct50] = det_steady(T50, n);
[urls50, probs50] = det_urls(U, P50, n);
[urlss50, probss50] = det_urls(U, Ps50, n);

p = .25;

[T25, sums] = transition2(G, p, n);
[V, bad, badD, numone, P25] = eigen(T25, n);
[Ps25, ct25] = det_steady(T25, n);
[urls25, probs25] = det_urls(U, P25, n);
[urlss25, probss25] = det_urls(U, Ps25, n);

p = .01;

[T01, sums] = transition2(G, p, n);
[V, bad, badD, numone, P01] = eigen(T01, n);
[Ps01, ct01] = det_steady(T01, n);
[urls01, probs01] = det_urls(U, P01, n);
[urlss01, probss01] = det_urls(U, Ps01, n);