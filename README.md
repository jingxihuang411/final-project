# Blockchain for Developers: Video Hunter

## Overview

Video Hunter is a decentralized platform for people to crowdsource videos. With the development of technology and more leisure time, people are not only interested in watching movies but also begins to make their own videos. Video Hunter provides people with the opportunities to share their owned videos with others while gaining rewards for each purchase of their videos.

## Functionalities
### Video Providers
1. provide video sources and specify the minimum price that they want charge for each purchase of the video.
2. retrieve the ether they've gained from the video if the quality of the video passed a threshold (score higher than 70 out of 100 in this case) and the number of buyers is greater than price * threshold (threshold is set to 10 in this case). The quality of the video is measured by number of people voted good divided by total number of people purchased. In other words, for a video with price of 1 dollar, the video provider needs to have 10 buyers and more than 7 buyers voting good in order to retrieve the ether gained.
3. provider should be able to check the current number of buyers and scores for video provided.


### Video Hunters
1. check current number of buyers, votes and scores for the video provided by video providers.
2. get the minimum price they need to pay for watching the video and send ether to video providers' contract in order to buy the video they want to watch. Video hunters can give extra amount of money to the video provider if they really like the video.
3. vote yes on the quality of the video if they think the video is worth the price. Video hunters are able to change vote and can vote at most once for the video they've purchased.


## Usage
This Dapp will utilize truffle-box(https://truffle-box.github.io/) and use React as Javascript front-end framework for user interaction. The basic idea behind the dapp is that video providers can upload their own videos to the contract with name, basic information and specified minimum purchase price in etherum for each video. On the other hand, video hunters can use the app to access video they would like to watch by paying more than the minimum amount specified by the provider. After watching the video, video hunters can vote whether they think the video is worth the money they paid. Once the video has score and number of buyers greater than threshold, video providers can retrieve the rewards they've gained from the video.

## User Interaction
You will need to install MetaMask in your browser and set network to truffle develop(http://localhost:9545) when testing. 
1. If you try to approve a video that you haven’t purchase or already voted before, you will error message
2. When you click on purchase to buy the video you want, if the purchase is successful, you will get the url to retrieve the video. Else, an error message will be returned
3. After purchasing the video, you can choose to approve the video if you think it’s worth the price. 
4. The backend of the project is fully implemented with more functions, eg. Add movies, score calculation, retrieve funds when video quality is above criteria. 
