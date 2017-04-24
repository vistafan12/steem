---
permalink: /getinvolved/paid-to-curate/
title: Curation Rewards
subtitle: Earn STEEM by being the first to upvote popular content
image: ../images/frontpage/ico-paid-curate-5.svg
priority: 2
summary: >
    Every post submitted to STEEM is voted upon by users. These votes help other users identify
    content that is worth their limited attention and bring significant value to the platform. Steem
    recognizes that sifting through the abundance of new submissions is work that deserves to
    be rewarded.

---

## Voting on Posts

  Users with vesting STEEM have the ability to vote on posts. *Voting Power* is rate-limited and
  decays by up to 5% every time a vote is cast. *Voting Power* regenerates to 100% over 24 hours. Your
  ability to impact the payouts a post receives is based upon your current Voting Power times the
  total *vesting STEEM* and is known as *STEEM Power*.

  To maximize total STEEM Power applied to posts, users should vote on at least 20 posts per day. Voting
  on more than 20 posts per day has exponentially decreasing influence on total STEEM Power used.

## How it Works

  Every time a post gets paid, 50% of the payout is directed toward those who contributed
  the most to increasing the posts payout.  To maximize your potential payout from voting you should
  follow these simple rules:

  1. Only vote on posts that you believe others will also vote for.
  2. Vote as early as possible after the content is posted.
  3. Don't vote on content that is already popular
  4. Acquire as much vesting STEEM Power as possible

  The less *STEEM Power* you have the more important it is for you to focus your votes on a
  few good posts rather than spreading your vote thin. In particular, users with small amounts
  of vesting STEEM should:

  1. Vote on content others haven't voted for, to maximize the percentage increase in voting
  2. Vote on fewer posts, the more you vote the more diluted your STEEM Power.

## Challenges with Rewarding Voting

  The saying you "get what you pay for" has never been more true. In this case we must be
  "careful what we pay for" or we might not get the result that we want. If Steem simply paid
  people for voting then tech-savy individuals would simply vote for everything to maximize
  their payout. This type of behavior would add no new information and therefore no value to
  the platform. The reward algorithm must be designed to reward information while preventing
  gaming and automation.

### Reward Percentage Increase in Voting

  The algorithm has been carefully designed to minimize the impact of automated voting
  algorithms. In particular, we want to reward voting on posts that the network
  has the "least information" about. This means that being the first person to vote for
  a post gives you the greatest possible weight for your STEEM Power.

  A human has a better chance of predicting the success of a random post with no votes than
  a computer algorithm. At best a computer algorithm could use historic performance of the
  poster to guess. If an algorithm is used, it will have to be a sophisticated algorithm
  that actually does add some value. After all, the algorithm isn't able to vote on everything
  and gets exponentially weaker more it dilutes its vote.

  Someone who adds 1 vote to a post that already has 99 votes will get a weight of
  .01.  On the other hand, someone who adds 99 votes to a post that
  already has 99 votes will end up with a weight of 25.

  The order of voting matters. Given 4 users with 1 vote, and 1 user with 4 votes the
  payout received by individual voters can be dramatically different. If the 1 vote
  users vote first, then their weights will be:

      Vote:      1,   1,  1,  1,   4
      Weights: 100,  25,  9,  6,  25
      Percent: 60%, 15%, 5%, 3%, 15%

  If the order were reversed then the weights would be:

      Vote:      4,  1,  1,  1,  1
      Weights: 100,  4,  3,  2,  2
      Percent: 90%, 3%, 2%, 2%, 2%

### Reward Vote Concentration

  Human voters can only process so much content per day. A script that votes on everything is
  guaranteed to have a much smaller percentage of the winning posts than someone who applies
  some human intuition. This vote concentration is rewarded automatically by paying out
  rewards based upon percentage increase in total votes, with one small caveat: the first voters
  can have very large percentage increases with very small stake.

  Imagine someone who has 4 accounts with STEEM Power of 1, 2, 3 and 6. If they vote consecutively,
  then each vote after the first would see a 50% increase, with the first vote seeing 100%.  If we
  were to sum the weights based solely on (percent increase)<sup>2</sup>, the attacker would start out
  with 1.75 using this strategy compared to starting out with 1.0 by voting from one account with 12 STEEM Power.

  Ideally, it should always be better to vote with 1 account than to divide up your stake and vote
  from multiple accounts.  To achieve this we multiply the (percent increase)<sup>2</sup> by the STEEM power of
  the vote.  This gives the following vote weights:

     Multiple Accounts: 1 + 1 + 1.5 + 3 => 6.5
     Single Account: 12

  The conclusion is that someone voting with all of their stake at once gets twice the final payout of the same
  individual voting multiple times through multiple accounts. It is true that the rich get richer when
  viewed from the perspective of an individual post, but when viewed as a whole the playing field is
  much more even. Regardless of how rich someone is, they can only evaluate so much content.  The rich
  individual also has the most to lose from poor voting.


## The Math

  The network will automatically divide the 50% payout among all users who voted for a post on a
  pro-rata basis using the following equation to measure the weight of each voter:

    let total_vote_reward         = 50% of the content reward
    let steem_power               = the total STEEM power of the vote
    let current_total_steem_power = the combined STEEM power of all past votes
    let new_total_steem_power     = current_total_steem_power + steem_power;
    let vote_payout_weight        = steem_power * (steem_power/new_total_steem_power)^2
    let total_vote_payout_weight  = sum vote_payout_weight for all votes on the post

    let vote_payout = total_vote_reward * vote_payout_weight / total_vote_payout_weight


## Disclaimer

    Any numbers or equations presented above are notional and may contain errors. The actual rewards
    are defined the by the open source software. It is your responsiblity to review the code or hire
    someone to review it for you.
