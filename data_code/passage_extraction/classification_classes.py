"""
A class with data used to assign difficulty weights to passages based
on the lexical frequencies of words in the passage. 

ranks: a list of string categories for lexical frequency ranges
ranges: a 2D list of the numeric range for each rank
weights: a list of the weight penalties assigned per word for each rank
"""
class Rank:

    def __init__(self, name, ranks, ranges, weights):
        self.name = name
        self.ranks = ranks 
        self.ranges = ranges 
        self.weights = weights 

""" 
A class to store different ranking scales. 
"""
class Ranks:

    # Using 2-elem lists is far faster than searching entire ranges. 
    # Rather than if i in range(), check if i > l[0] and <= l[1].
    # Using this method scales runtime from ~0:04:30 to ~0:00:15.
    _3_ranks = Rank(
        "3_ranks",
        ['Frequent', 'Uncommon', 'Rare'],
        [
            [100, 51000],
            [10, 100],
            [1, 10],
        ],
        [1, 3, 7]
    )
   
    _4_ranks = Rank(
        "4_ranks",
        ['Frequent', 'Medium', 'Uncommon', 'Rare'],
        [
            [100, 51000],
            [50, 100],
            [10, 50],
            [1, 10],
        ],
        [1, 4, 5, 8]
    )

    _5_ranks_a = Rank(
        "5a_ranks",
        ['Frequent', 'Common', 'Medium', 'Uncommon', 'Rare'],
        [
            [500, 51000],
            [250, 500],
            [150, 250],
            [50, 150],
            [1, 50],
        ],
        [1, 2, 3, 5, 8]
    )

    _5_ranks_b = Rank(
        "5b_ranks",
        ['Frequent', 'Common', 'Infrequent', 'Rare', 'Scarce'],
        [
            [200, 51000],
            [100, 200],
            [50, 100],
            [20, 50],
            [1, 20],
        ],
        [1, 1.5, 3, 5, 8]
    )

    _7_ranks = Rank(
        "7_ranks",
        ['Abundant', 'Frequent', 'Common', 'Average', 'Uncommon', 'Rare', 'Scarce'],
        [
            [800, 51000],
            [400, 800],
            [200, 400],
            [100, 200],
            [50, 100],
            [15, 50],
            [1, 15],
        ],
        [1, 1.1, 1.3, 1.7, 3, 5.5, 8.5]
    )

    _10_ranks = Rank(
        "10_ranks",
        ['Abundant', 'Frequent', 'Common', 'Average', 'Uncommon', 'Rare', 'Rarer', 'Scarce', 'Scarcer', 'Scarcest'],
        [
            [1000, 51000],
            [400, 1000],
            [200, 400],
            [100, 200],
            [50, 100],
            [40, 50],
            [30, 40],
            [20, 30],
            [10, 20],
            [1, 10]
        ],
        [1, 1.1, 1.3, 1.7, 3, 5.5, 7, 8, 9, 10]
    )

    all_ranks = [
        _3_ranks,
        _4_ranks,
        _5_ranks_a,
        _5_ranks_b,
        _7_ranks,
        _10_ranks
    ]

    # Create frequency ranking buckets for a variety of lexical ranges.
    def rank_scales(self, rank_scale):
        rank_scales = []
        # Check if more than one rank scale has been passed in. 
        if type(rank_scale) is list:
            for r_s in rank_scale:
                rank_scales.append(self.get_rank_dict(r_s))
        else:
            rank_scales.append(self.get_rank_dict(rank_scale))
        return rank_scales
    
    # Auxiliary function to create a single rank_scale dictionary.
    def get_rank_dict(self, rank_scale):
        rank_dict = {}
        for i in range(len(rank_scale.ranks)):
            rank_dict[rank_scale.ranks[i]] = {
                'range': rank_scale.ranges[i],
                'weight': rank_scale.weights[i]
            }
        return rank_dict 


"""
A class that contains data to help assign difficulty weights to 
any portion of Hebrew text that has more than one word. 
"""
class Classify:
    
    """ 
    Notes on stop_words_types and other exclusion lists. 

    Most prepositions, articles, and conjunctions don't
    add any meaningul weight to a text and could thus be exlcuded.
    
    Example use:
    words = [w for w in passage if F.sp.v(w) not in stop_words_types]
    
    Note: the only Heb article is 'הַ' with 30,386 occurences. There are some 
    preps and conjs that have few occurences, so I recommend not using
    stop_words_types when weighing passages and using stop_words instead.
    """
    stop_words_types = ['prep', 'art', 'conj']
    # Check if F.voc_lex_utf8.v(word) is in this list. If
    # so it can be excluded since it occurs so often. 
    stop_words = ['אֵת', 'בְּ', 'לְ', 'הַ', 'וְ']
    # If you take verb data into account when weighing a
    # paragraph, these common types could be excluded. 
    easy_vtypes = ['perf', 'impf', 'wayq']
    easy_vstems = ['qal', 'hif', 'nif', 'piel']