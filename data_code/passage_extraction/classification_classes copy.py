"""
A class with data used to assign difficulty weights to passages based
on the lexical frequencies of words in the passage. 

ranks: categories for lexical frequency ranges
ranges: a 2D list of the numeric range for each rank
weights: the weight penalty assigned per word for each rank
"""
class Ranks:
    _3_categories = ['Frequent', 'Uncommon', 'Rare']
    _4_categories = ['Frequent', 'Medium', 'Uncommon', 'Rare']
    _5_categories_a = ['Frequent', 'Common', 'Medium', 'Uncommon', 'Rare']
    _5_categories_b = ['Frequent', 'Common', 'Infrequent', 'Rare', 'Scarce']
    _7_categories = ['Abundant', 'Frequent', 'Common', 'Average', 'Uncommon', 'Rare', 'Scarce']
    _10_categories = ['Abundant', 'Frequent', 'Common', 'Average', 'Uncommon', 'Rare', 'Rarer', 'Scarce', 'Scarcer', 'Scarcest']

    # Using 2-elem lists is far faster than searching ranges. 
    # Rather than if i in range(), check if i > l[0] and <= l[1].
    # Using this method scales runtime from ~0:04:30 to ~0:00:15.
    _3_ranges = [
        [100, 51000],
        [10, 100],
        [1, 10],
    ]
    _3_weights = [1, 3, 7]

    _4_ranges = [
        [100, 51000],
        [50, 100],
        [10, 50],
        [1, 10],
    ]
    _4_weights = [1, 4, 5, 8]

    _5_ranges_a = [
        [500, 51000],
        [250, 500],
        [150, 250],
        [50, 150],
        [1, 50],
    ]
    _5_weights_a = [1, 2, 3, 5, 8]

    _5_ranges_b = [
        [200, 51000],
        [100, 200],
        [50, 100],
        [20, 50],
        [1, 20],
    ]
    _5_weights_b = [1, 1.5, 3, 5, 8]

    _7_ranges = [
        [800, 51000],
        [400, 800],
        [200, 400],
        [100, 200],
        [50, 100],
        [15, 50],
        [1, 15],
    ]
    _7_weights = [1, 1.1, 1.3, 1.7, 3, 5.5, 8.5]

    _10_ranges = [
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
    ]
    _10_ranges = [1, 1.1, 1.3, 1.7, 3, 5.5, 7, 8, 9, 10]

    all_ranks = [
        _5_categories_a, 
        _7_categories, 
        _4_categories, 
        _3_categories, 
        _5_categories_b,
        _10_categories,
    ]
    all_ranges = [
        _5_ranges_a, 
        _7_ranges, 
        _4_ranges, 
        _3_ranges, 
        _5_ranges_b,
        _10_ranges, 
    ]
    all_weights = [
        _5_weights_a, 
        _7_weights, 
        _4_weights, 
        _3_weights, 
        _5_weights_b,
        _10_ranges,
    ]

"""
A class that contains data to help assign difficulty weights to 
any portion of Hebrew text that has more than one word. 
"""
class Classify:
    
    # Pass in your choice of ranges and weights from the Ranks class.
    def __init__(self, ranks={}, ranges={}, weights={}):
        self.ranks = ranks
        self.ranges = ranges 
        self.weights = weights

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

    """
    rank_scale() returns a dict containing frequency ranking 
    buckets for a variety of lexical ranges.
    
    Example use of rank_scale():

    r = Ranks()
    rank_scale = Classify(r.ranks1, r.ranges1, r.weights1).rank_scale()
    for rank in rank_scale.keys():
        lex_freq = F.freq_lex.v(word)
        range = rank_scale[rank]['range']
        if lex_freq >= range[0] and lex_freq < range[1]:
            total_weight += rank_scale[rank]['weight']
    """
    # Create frequency ranking buckets for a variety of lexical ranges.
    def rank_scale(self):
        rank_scale = {}
        for i in range(len(self.ranks)):
            rank_scale[self.ranks[i]] = {
                'range': self.ranges[i],
                'weight': self.weights[i]
            }
        return rank_scale 