---
permalink: /getinvolved/posting-rewards/
title: Posting Rewards
subtitle: Earn STEEM every time you post content valued by others.
image: ../images/frontpage/ico-paid-post-3.svg
priority: 1
summary: >
    Every post submitted to STEEM is voted upon by users with a vested interest in the
    long-term value of STEEM. The more votes a post receives the more money the poster makes.
    Posters are also rewarded anytime someone inspires others to create replies that also
    get up voted.

---

## Rewarding Discussion

One of the primary goals of Steem's reward system is to produce the best discussions on the internet. Each
and every year 10% of the market capitalization of Steem is distributed to users submitting, voting on, and discussing content.
At the size of Bitcoin this could be as much as **$1.75 million dollars per day** being given to top contributors.

### Payout Distribution

<img style="float:right; margin-left:2em;" src="/images/longtail.jpg"/>

The actual distribution will depend upon the voting patterns of users, but we suspect that the vast majority
of the rewards will be distributed to the most popular content. Steem weighs payouts proportional to
n<sup>2</sup> the amount of vesting STEEM voting for a post. In other words, post number x would receive a payout
proportional to votes[x]<sup>2</sup> / sum(votes[0...n])<sup>2</sup>).

[Zipf's Law](https://en.wikipedia.org/wiki/Zipf%27s_law) is one of those empirical rules that characterize a
surprising range of real-world phenomena remarkably well.  It says that if we order some large collection by
size or popularity, the second element in the collection will be about half the measure of the first one,
the third one will be about one-third the measure of the first one, and so on. In general, the k th-ranked item
will measure about 1/k of the first one.

Taking popularity as a rough measure of value, then the value of each individual item is given by Zipf's Law.
That is, if we have a million items, then the most popular 100 will contribute a third of the total value,
the next 10,000 another third, and the remaining 989,900 the final third. The value of the collection of
n items is proportional to log( n ).

The impact of this voting and payout distribution is to offer large bounties for good content while still
rewarding smaller players for their long-tail contribution.

### Rewarding Parent Posts

Good discussion requires back and forth posting. When you reply to someone else, they get 50% of any payout you
receive in that thread.  This rule applies up to 6 levels deep. Starting a big discussion greatly rewards the
parent poster.

Failure to properly nest your posts in the discussion is a good way to get down voted.

### Payouts

When a post is receives a payout it takes the form of 50% STEEM backed dollars, [SBD](/features/steem-backed-dollars/), and 50%
vesting STEEM. The vesting STEEM give the user increased voting and transaction power while the SBD gives the user an immediate benefit in
a stable currency.  Both vesting [STEEM](/features/steem-currency/) and SBD pay interest for holding them rather than selling.

### Down Voting Posts

Where as up voting posts benefits an individual at the expense of everyone else, down voting benefits everyone else
at the expense of the individual doing the voting. In effect, a down vote represents a lost opportunity to vote
for yourself.  In a perfect world we would reward the least-down voted content because such a system cannot be cheated.

The reality is that attitude matters. It feels better supporting something you like than resisting that which you don't like. It also
requires more work to flag all of the bad content than to identify the relatively small amount of quality content.

## Voting Algorithm

When a user posts on Steem others are given an opportunity to vote for (or against) the post. Users
votes are weighted by the amount of *vesting* STEEM held in their account. The goal of the voting
algorithm is to reward posts with the greatest consensus or network effect.  We know that network
effect grows on the order of *n*<sup>2</sup> the number of participants; therefore, rewards are
distributed proportional to voting *weight*<sup>2</sup>.

This algorithm has been designed to discourage voting for yourself and reward teeming up with others. If
votes were not scored by *weight*<sup>2</sup> then users would gain more by voting for themselves than
by voting with others.

### Limited Voting Rate

Each account is rate limited on how frequently it can vote in order to prevent automated scripts from
having more effective power than manual voting. This rate limiting is implemented by dividing the voting
weight over all votes by an account in a 24 hour period. Someone who votes for 100 posts a day will have each
vote worth about 1% of their weight.

Attempts to bypass the rate limiting through the creation of multiple accounts will divide the stake and give
the attacker no additional power.

### Encourage Distribution of Voting

Each account is only allowed to vote with up to 5% of its voting weight on any given post. To maximize its
voting power, an account must vote for at least 20 items per day.

## 24 hour Review Period

After a post receives its first vote, a 24 hour countdown begins during which additional votes may be cast. Each
additional vote extends the countdown such that the final payout time is a vote-weighted average of 24 hours after
each vote. The pending payout is used to identify *trending* posts. These posts get promoted to the front page where
they receive the most scrutiny.

Anyone attempting to selfishly vote for themselves will find other users with a vested interest in the value of their
STEEM will be quick to vote them down.

   > ## [The Story of the Crab Bucket](http://guidezone.e-guiding.com/jmstory_crabs.htm)
   >
   > A man was walking along the beach and saw another man fishing in the surf with a bait bucket beside him. As he drew closer, he saw that the bait bucket had no lid and had live crabs inside.
   >
   > "Why don't you cover your bait bucket so the crabs won't escape?", he said.
   >
   > "You don't understand.", the man replied, "If there is one crab in the bucket it would surely crawl out very quickly. However, when there are many crabs in the bucket, if one tries to crawl up the side, the others grab hold of it and pull it back down so that it will share the same fate as the rest of them."
   >
   > So it is with people. If one tries to do something different, get better grades, improve herself, escape her environment, or dream big dreams, other people will try to drag her back down to share their fate.

There is another way to interpret *The Story of the Crab Bucket*. People don't like it when other people get something they cannot have. Anyone attempting to
get ahead by voting for themselves will be actively resisted and voted against. Some crabs may escape with ill-gotten STEEM, but the vast majority will
be kept in the bucket and that is all that matters.

## Voting Guide

The goal STEEM is to be an open platform for civilized discourse on quality content. Users who vote according to this guide will help
maximize the value of the platform and the value of their STEEM.

The following definition of good content is borrowed from [hubski.com](http://hubski.com).  

> The best responses are those that generate thoughtful, civil conversation. You don't have to agree with others, but be respectful. Good responses are not necessarily popular perspectives, but are well-supported ones.
>
> If you assert a strong opinion, try to back it up with facts, or an insightful rationale.
>
>In addition to defining what content is desired, the it is also useful to provide guidance on undesirable content.  Any submissions that meet one or more of the following criteria (borrowed from reddit.com) should be voted down.
>
> - [NSFW (Not Safe For Work) content](https://en.wikipedia.org/wiki/Not_safe_for_work)
> - Encourages or incites violence
> - Threatens, harasses, or bullies or encourages others to do so
> - Impersonates someone in a misleading or deceptive manner
> - Is spam
> - Links to viruses or malware
> - Is improperly categorized or not relevant to the conversation

As a general rule users should vote based upon whether or not a particular piece of content adds or removes value to the discussion. Sometimes this means voting for people who express opinions you disagree with. A community that devolves into group-think will lose value, so it is in the best interest of everyone to vote according to the bigger picture.
