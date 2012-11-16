/*
    Suffix array (nlogn)
    Ivan Smirnov
    2012 Nov 16
*/

int sa[maxn], nsa[maxn], bl[maxn], pbl[maxn], cnt[maxn], nbl;

void buildSA()
{
    forn(i, n) sa[i] = i;
    forn(i, n) bl[i] = s[i];
    nbl = *max_element(bl, bl+n) + 1;

    for (int d = 0; d < n; d = d ? d*2 : 1)
    {
        forn(i, n) nsa[i] = (sa[i]-d+n)%n;
        forn(i, nbl) cnt[i] = 0;
        forn(i, n) ++cnt[bl[sa[i]]];
        forn(i, nbl) if (i) cnt[i] += cnt[i-1];
        for (int i = n-1; i >= 0; --i) sa[--cnt[bl[nsa[i]]]] = nsa[i];

        nbl = -1;
        forn(i, n)
        {
            if (i == 0 || bl[sa[i]] != bl[sa[i-1]] || bl[(sa[i]+d)%n] != bl[(sa[i-1]+d)%n])
                ++nbl;
            pbl[sa[i]] = nbl; 
        }
        ++nbl;
        forn(i, n) bl[i] = pbl[i];
    }
}
