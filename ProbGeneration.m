prb_arr = 'goodnight father and cop <s> if hurt go out hospital <s> father decide to go out <s> father is cop <s> cop can here <s> cop find cat <s> cop find father <s> cop hear about deaf cat and decide <s> gold cost islarge <s> deaf father hear about day';

newStr = split(prb_arr);


xx = cellstr(newStr);
keySet=unique(xx,'stable');
valueSet=cellfun(@(x) sum(ismember(xx,x)),keySet,'un',0);

M = containers.Map(keySet,valueSet);
